module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::forge {
    struct Recipe has copy, drop, store {
        scrap: u64,
        poison: u64,
        remedy: u64,
    }

    struct Forge has key {
        id: 0x2::object::UID,
        version: u64,
        shed: 0x2::object::ID,
        open: bool,
        fee: u64,
        payee: address,
        repairs: vector<Recipe>,
        replacement: Recipe,
        fuse_scrap: u64,
        recycle_scrap: u64,
    }

    struct ForgeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Forged has copy, drop {
        action: u8,
        wallet: address,
        shovel: 0x2::object::ID,
        fee: u64,
        scrap: u64,
        poison: u64,
        remedy: u64,
    }

    struct ForgeConfigured has copy, drop {
        forge: 0x2::object::ID,
        open: bool,
        fee: u64,
        payee: address,
        repairs: vector<Recipe>,
        replacement: Recipe,
        fuse_scrap: u64,
        recycle_scrap: u64,
    }

    fun charge(arg0: &Forge, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0.fee;
        if (v0 == 0) {
            return 0
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 505);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg2), arg0.payee);
        v0
    }

    fun check_admin(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &Forge) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == arg1.shed, 501);
        assert!(arg1.version == 3, 500);
    }

    fun configured(arg0: &Forge) {
        let v0 = ForgeConfigured{
            forge         : 0x2::object::id<Forge>(arg0),
            open          : arg0.open,
            fee           : arg0.fee,
            payee         : arg0.payee,
            repairs       : arg0.repairs,
            replacement   : arg0.replacement,
            fuse_scrap    : arg0.fuse_scrap,
            recycle_scrap : arg0.recycle_scrap,
        };
        0x2::event::emit<ForgeConfigured>(v0);
    }

    public fun forge_id(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid(arg0);
        let v1 = ForgeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ForgeKey>(v0, v1)) {
            let v3 = ForgeKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<ForgeKey, 0x2::object::ID>(v0, v3))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun fuse(arg0: &Forge, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg3: &0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg7: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel {
        let v0 = ready(arg0, arg1, 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg2), arg3, arg4, arg5, arg9);
        let (v1, v2) = if (0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::dug(&arg6) > 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::dug(&arg7) || 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::dug(&arg6) == 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::dug(&arg7) && 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::serial(&arg6) < 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::serial(&arg7)) {
            (arg6, arg7)
        } else {
            (arg7, arg6)
        };
        let v3 = v1;
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::fuse(arg2, &mut v3, v2, v0, 0x2::clock::timestamp_ms(arg8), arg9);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::spend_scrap(arg1, v0, arg0.fuse_scrap);
        let v4 = Forged{
            action : 3,
            wallet : v0,
            shovel : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel>(&v3),
            fee    : 0,
            scrap  : arg0.fuse_scrap,
            poison : 0,
            remedy : 0,
        };
        0x2::event::emit<Forged>(v4);
        v3
    }

    entry fun migrate(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Forge) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == arg1.shed, 501);
        assert!(arg1.version < 3, 500);
        arg1.version = 3;
    }

    entry fun open_forge(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1), 501);
        let v0 = ForgeKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<ForgeKey>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid(arg1), v0), 502);
        let v1 = Recipe{
            scrap  : 8,
            poison : 2,
            remedy : 4,
        };
        let v2 = Recipe{
            scrap  : 14,
            poison : 4,
            remedy : 8,
        };
        let v3 = 0x1::vector::empty<Recipe>();
        let v4 = &mut v3;
        0x1::vector::push_back<Recipe>(v4, v1);
        0x1::vector::push_back<Recipe>(v4, v2);
        let v5 = Recipe{
            scrap  : 16,
            poison : 4,
            remedy : 8,
        };
        let v6 = Forge{
            id            : 0x2::object::new(arg3),
            version       : 3,
            shed          : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1),
            open          : false,
            fee           : 100000000,
            payee         : arg2,
            repairs       : v3,
            replacement   : v5,
            fuse_scrap    : 8,
            recycle_scrap : 2,
        };
        let v7 = ForgeKey{dummy_field: false};
        0x2::dynamic_field::add<ForgeKey, 0x2::object::ID>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid_mut(arg1), v7, 0x2::object::id<Forge>(&v6));
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::open_reservations(arg1, 7 * 86400000, arg3);
        configured(&v6);
        0x2::transfer::share_object<Forge>(v6);
    }

    fun ready(arg0: &Forge, arg1: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: 0x2::object::ID, arg3: &0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x2::tx_context::TxContext) : address {
        assert!(arg0.version == 3, 500);
        assert!(arg0.open, 503);
        assert!(arg0.shed == arg2 && 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::shed_of(arg1) == arg2, 504);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::prove(arg3, arg4, arg5, false);
        0x2::tx_context::sender(arg6)
    }

    fun recipe(arg0: u64, arg1: u64, arg2: u64) : Recipe {
        let v0 = if (arg0 <= 100) {
            if (arg1 <= 50) {
                arg2 <= 50
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 507);
        Recipe{
            scrap  : arg0,
            poison : arg1,
            remedy : arg2,
        }
    }

    public fun recycle(arg0: &Forge, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg3: &0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = ready(arg0, arg1, 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg2), arg3, arg4, arg5, arg8);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::destroy(arg2, arg6, arg8);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::reserve(arg2, v0, 0x2::clock::timestamp_ms(arg7));
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::add_scrap(arg1, v0, arg0.recycle_scrap);
        let v1 = Forged{
            action : 1,
            wallet : v0,
            shovel : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel>(&arg6),
            fee    : 0,
            scrap  : arg0.recycle_scrap,
            poison : 0,
            remedy : 0,
        };
        0x2::event::emit<Forged>(v1);
    }

    public fun repair(arg0: &Forge, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg3: &0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg7: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison, arg8: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = ready(arg0, arg1, 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg2), arg3, arg4, arg5, arg10);
        let v1 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::repairs(arg6);
        let v2 = if (v1 < 0x1::vector::length<Recipe>(&arg0.repairs)) {
            *0x1::vector::borrow<Recipe>(&arg0.repairs, v1)
        } else {
            *0x1::vector::borrow<Recipe>(&arg0.repairs, 0x1::vector::length<Recipe>(&arg0.repairs) - 1)
        };
        let v3 = v2;
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::repair(arg2, arg6);
        spend(arg1, v0, &v3, arg7, arg8);
        let v4 = Forged{
            action : 0,
            wallet : v0,
            shovel : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel>(arg6),
            fee    : charge(arg0, arg9, arg10),
            scrap  : v3.scrap,
            poison : v3.poison,
            remedy : v3.remedy,
        };
        0x2::event::emit<Forged>(v4);
    }

    public fun replace(arg0: &Forge, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg3: &0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison, arg7: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel {
        let v0 = ready(arg0, arg1, 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg2), arg3, arg4, arg5, arg10);
        let v1 = arg0.replacement;
        spend(arg1, v0, &v1, arg6, arg7);
        let v2 = charge(arg0, arg8, arg10);
        let v3 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::replacement(arg2, v0, 0x2::clock::timestamp_ms(arg9), v2, arg10);
        let v4 = Forged{
            action : 2,
            wallet : v0,
            shovel : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel>(&v3),
            fee    : v2,
            scrap  : v1.scrap,
            poison : v1.poison,
            remedy : v1.remedy,
        };
        0x2::event::emit<Forged>(v4);
        v3
    }

    entry fun set_fee(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Forge, arg2: u64, arg3: address) {
        check_admin(arg0, arg1);
        assert!(arg2 <= 1000000000, 508);
        arg1.fee = arg2;
        arg1.payee = arg3;
        configured(arg1);
    }

    entry fun set_open(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Forge, arg2: bool) {
        check_admin(arg0, arg1);
        arg1.open = arg2;
        configured(arg1);
    }

    entry fun set_recipes(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Forge, arg2: vector<u64>, arg3: vector<u64>, arg4: u64, arg5: u64) {
        check_admin(arg0, arg1);
        let v0 = if (0x1::vector::length<u64>(&arg2) >= 3) {
            if (0x1::vector::length<u64>(&arg2) % 3 == 0) {
                0x1::vector::length<u64>(&arg3) == 3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 507);
        let v1 = 0x1::vector::empty<Recipe>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg2)) {
            0x1::vector::push_back<Recipe>(&mut v1, recipe(*0x1::vector::borrow<u64>(&arg2, v2), *0x1::vector::borrow<u64>(&arg2, v2 + 1), *0x1::vector::borrow<u64>(&arg2, v2 + 2)));
            v2 = v2 + 3;
        };
        arg1.repairs = v1;
        arg1.replacement = recipe(*0x1::vector::borrow<u64>(&arg3, 0), *0x1::vector::borrow<u64>(&arg3, 1), *0x1::vector::borrow<u64>(&arg3, 2));
        assert!(arg4 <= 100 && arg5 <= 10, 507);
        assert!(arg1.replacement.scrap >= arg5, 507);
        arg1.fuse_scrap = arg4;
        arg1.recycle_scrap = arg5;
        configured(arg1);
    }

    entry fun set_reservation_days(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &Forge, arg2: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg3: u64) {
        check_admin(arg0, arg1);
        assert!(0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg2) == arg1.shed, 504);
        assert!(arg3 >= 1 && arg3 <= 30, 507);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::set_reservation_ms(arg2, arg3 * 86400000);
    }

    fun spend(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: address, arg2: &Recipe, arg3: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison, arg4: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(arg3) >= arg2.poison && 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(arg4) >= arg2.remedy, 506);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::spend_scrap(arg0, arg1, arg2.scrap);
        let v0 = 0;
        while (v0 < arg2.poison) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::use_poison(arg3);
            v0 = v0 + 1;
        };
        let v1 = 0;
        while (v1 < arg2.remedy) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::use_remedy(arg4);
            v1 = v1 + 1;
        };
    }

    public fun terms(arg0: &Forge) : (bool, u64, vector<u64>, vector<u64>, u64, u64) {
        let v0 = vector[];
        let v1 = &arg0.repairs;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Recipe>(v1)) {
            let v3 = 0x1::vector::borrow<Recipe>(v1, v2);
            0x1::vector::push_back<u64>(&mut v0, v3.scrap);
            0x1::vector::push_back<u64>(&mut v0, v3.poison);
            0x1::vector::push_back<u64>(&mut v0, v3.remedy);
            v2 = v2 + 1;
        };
        let v4 = &arg0.replacement;
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, v4.scrap);
        0x1::vector::push_back<u64>(v6, v4.poison);
        0x1::vector::push_back<u64>(v6, v4.remedy);
        (arg0.open, arg0.fee, v0, v5, arg0.fuse_scrap, arg0.recycle_scrap)
    }

    // decompiled from Move bytecode v7
}

