module 0x398f78b2b9e2691278fcceb80255ca71f541a719e3b1da317ce1645b56633ec1::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        vaults_by_owner: 0x2::table::Table<address, vector<0x2::object::ID>>,
        vaults_by_heir: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_vaults: u64,
    }

    public fun get_vaults_by_heir(arg0: &Registry, arg1: address) : &vector<0x2::object::ID> {
        0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.vaults_by_heir, arg1)
    }

    public fun get_vaults_by_owner(arg0: &Registry, arg1: address) : &vector<0x2::object::ID> {
        0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.vaults_by_owner, arg1)
    }

    public fun has_heir(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vaults_by_heir, arg1)
    }

    public fun has_owner(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vaults_by_owner, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Registry>(new_registry(arg0));
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : Registry {
        Registry{
            id              : 0x2::object::new(arg0),
            vaults_by_owner : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            vaults_by_heir  : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_vaults    : 0,
        }
    }

    public(friend) fun reassign_heir(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: address, arg3: address) {
        if (arg2 == arg3) {
            return
        };
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vaults_by_heir, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.vaults_by_heir, arg2);
            remove_vault_id(v0, arg1);
        };
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vaults_by_heir, arg3)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.vaults_by_heir, arg3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.vaults_by_heir, arg3), arg1);
    }

    public(friend) fun register_vault(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: address, arg3: address) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vaults_by_owner, arg2)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.vaults_by_owner, arg2, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.vaults_by_owner, arg2), arg1);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vaults_by_heir, arg3)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.vaults_by_heir, arg3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.vaults_by_heir, arg3), arg1);
        arg0.total_vaults = arg0.total_vaults + 1;
    }

    fun remove_vault_id(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                0x1::vector::remove<0x2::object::ID>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun total_vaults(arg0: &Registry) : u64 {
        arg0.total_vaults
    }

    // decompiled from Move bytecode v6
}

