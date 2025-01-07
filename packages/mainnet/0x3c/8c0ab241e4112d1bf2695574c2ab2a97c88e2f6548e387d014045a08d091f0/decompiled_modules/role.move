module 0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::role {
    struct ROLE has drop {
        dummy_field: bool,
    }

    struct Role has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        serial_number: u64,
        role_data: RoleData,
        creater: address,
    }

    struct RoleData has store {
        id: 0x2::object::ID,
        profession: 0x1::string::String,
        level: u64,
        wallet: 0x2::balance::Balance<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::soul::SOUL>,
        xp: u64,
        fighting_system: Fighting,
        equipment_system: 0x1::option::Option<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::Sword>,
        task_system: vector<Task>,
    }

    struct Fighting has drop, store {
        hp: u64,
        attack_power: u64,
        kills: u64,
    }

    struct Monster has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        level: u64,
        monster_hp: u64,
        monster_attack: u64,
    }

    struct Task has drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        award_xp: u64,
        award_coin: u64,
        status: u64,
    }

    public entry fun attack_monster(arg0: Monster, arg1: &mut Role) {
        assert!(arg0.monster_hp > 0, 0);
        if (arg0.monster_hp >= arg1.role_data.fighting_system.attack_power) {
            arg0.monster_hp = arg0.monster_hp - arg1.role_data.fighting_system.attack_power;
        } else {
            arg0.monster_hp = 0;
        };
        if (arg0.monster_hp == 0) {
            arg1.role_data.fighting_system.kills = arg1.role_data.fighting_system.kills + 1;
            arg1.role_data.xp = arg1.role_data.xp + 10;
            let Monster {
                id             : v0,
                name           : _,
                level          : _,
                monster_hp     : _,
                monster_attack : _,
            } = arg0;
            0x2::object::delete(v0);
        } else {
            0x2::transfer::transfer<Monster>(arg0, arg1.creater);
        };
    }

    public entry fun check_task_low(arg0: &mut Role) {
        assert!(arg0.role_data.fighting_system.kills >= 3, 0);
        0x1::vector::borrow_mut<Task>(&mut arg0.role_data.task_system, 0).status = 2;
        arg0.role_data.fighting_system.kills = arg0.role_data.fighting_system.kills - 3;
    }

    public fun creat_task_low(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64) : Task {
        Task{
            name        : arg0,
            description : arg1,
            award_xp    : arg2,
            award_coin  : arg3,
            status      : 0,
        }
    }

    public entry fun create_monster_low(arg0: &0x2::random::Random, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 1, 10);
        let v2 = Monster{
            id             : 0x2::object::new(arg2),
            name           : 0x1::string::utf8(b"bad wolf"),
            level          : v1,
            monster_hp     : v1 + 5,
            monster_attack : v1 / 2,
        };
        0x2::transfer::transfer<Monster>(v2, arg1);
    }

    public entry fun create_role(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = if (arg1 == 0x1::string::utf8(b"warrior")) {
            0
        } else {
            1
        };
        let v2 = Role{
            id            : v0,
            name          : arg0,
            description   : arg2,
            serial_number : 0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::utils::create_role_serial_number(v1, &v0),
            role_data     : init_role_data(0x2::object::uid_to_inner(&v0), arg1),
            creater       : arg3,
        };
        0x2::transfer::public_transfer<Role>(v2, arg3);
    }

    fun init(arg0: ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://oss-of-ch1hiro.oss-cn-beijing.aliyuncs.com/imgs/202412052252266.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creater}"));
        let v4 = 0x2::package::claim<ROLE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Role>(&v4, v0, v2, arg1);
        0x2::display::update_version<Role>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Role>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun init_role_data(arg0: 0x2::object::ID, arg1: 0x1::string::String) : RoleData {
        RoleData{
            id               : arg0,
            profession       : arg1,
            level            : 0,
            wallet           : 0x2::balance::zero<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::soul::SOUL>(),
            xp               : 0,
            fighting_system  : init_warrior_fighting(),
            equipment_system : 0x1::option::none<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::Sword>(),
            task_system      : 0x1::vector::empty<Task>(),
        }
    }

    public fun init_warrior_fighting() : Fighting {
        Fighting{
            hp           : 10,
            attack_power : 5,
            kills        : 0,
        }
    }

    public entry fun put_on_ep(arg0: &mut Role, arg1: 0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::Sword) {
        arg0.role_data.fighting_system.attack_power = arg0.role_data.fighting_system.attack_power + 0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::return_property(&mut arg1);
        0x1::option::fill<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::Sword>(&mut arg0.role_data.equipment_system, arg1);
    }

    public entry fun receive_task_low(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &mut Role) {
        assert!(0x1::vector::is_empty<Task>(&arg4.role_data.task_system), 0);
        let v0 = creat_task_low(arg0, arg1, arg2, arg3);
        v0.status = 1;
        0x1::vector::push_back<Task>(&mut arg4.role_data.task_system, v0);
    }

    public entry fun send_rewards_low(arg0: &mut Role, arg1: &mut 0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::soul::CoinPool, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.role_data.xp = arg0.role_data.xp + 0x1::vector::borrow_mut<Task>(&mut arg0.role_data.task_system, 0).award_xp;
        0x2::balance::join<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::soul::SOUL>(&mut arg0.role_data.wallet, 0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::soul::withdraw_task_low_token(arg1));
        0x2::transfer::public_transfer<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::Sword>(0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::create_ep(0x1::string::utf8(b"smart_sword"), arg0.creater, arg2), arg0.creater);
        arg0.role_data.fighting_system.kills = arg0.role_data.fighting_system.kills - 3;
        0x1::vector::pop_back<Task>(&mut arg0.role_data.task_system);
    }

    public entry fun take_off_ep(arg0: &mut Role, arg1: address) {
        arg0.role_data.fighting_system.attack_power = arg0.role_data.fighting_system.attack_power - 0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::return_property(0x1::option::borrow_mut<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::Sword>(&mut arg0.role_data.equipment_system));
        0x2::transfer::public_transfer<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::Sword>(0x1::option::extract<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::equipment::Sword>(&mut arg0.role_data.equipment_system), arg1);
    }

    public entry fun transfer_coin(arg0: &mut Role, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::soul::SOUL>>(0x2::coin::from_balance<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::soul::SOUL>(0x2::balance::split<0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::soul::SOUL>(&mut arg0.role_data.wallet, arg2), arg3), arg1);
    }

    public entry fun up_level(arg0: &mut Role) {
        if (arg0.role_data.xp == 50) {
            arg0.role_data.level = arg0.role_data.level + 1;
            arg0.role_data.xp = 0;
            arg0.role_data.fighting_system.attack_power = arg0.role_data.fighting_system.attack_power + 2;
        };
    }

    // decompiled from Move bytecode v6
}

