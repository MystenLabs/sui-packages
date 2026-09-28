module 0x5837ff5762ecdff5647977f9443bb4ccac7f4e174dfbfd6ee1917f8425ea715f::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        owner: address,
        data: vector<u8>,
        wraps: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
        version: u64,
    }

    struct VaultCreated has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
    }

    struct VaultUpdated has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        version: u64,
    }

    public fun add_wrap(arg0: &mut Vault, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) <= 262144, 0);
        set_wrap_internal(arg0, arg1, arg2);
        bump(arg0, arg3);
    }

    fun bump(arg0: &mut Vault, arg1: &0x2::tx_context::TxContext) {
        arg0.version = arg0.version + 1;
        let v0 = VaultUpdated{
            vault   : 0x2::object::id<Vault>(arg0),
            owner   : 0x2::tx_context::sender(arg1),
            version : arg0.version,
        };
        0x2::event::emit<VaultUpdated>(v0);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Vault {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Vault{
            id      : 0x2::object::new(arg0),
            owner   : v0,
            data    : 0x1::vector::empty<u8>(),
            wraps   : 0x2::vec_map::empty<0x1::string::String, vector<u8>>(),
            version : 0,
        };
        let v2 = VaultCreated{
            vault : 0x2::object::id<Vault>(&v1),
            owner : v0,
        };
        0x2::event::emit<VaultCreated>(v2);
        v1
    }

    public fun create_and_keep(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0);
        0x2::transfer::transfer<Vault>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun data(arg0: &Vault) : &vector<u8> {
        &arg0.data
    }

    public fun destroy(arg0: Vault) {
        let Vault {
            id      : v0,
            owner   : _,
            data    : _,
            wraps   : _,
            version : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun has_wrap(arg0: &Vault, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg0.wraps, &arg1)
    }

    public fun owner(arg0: &Vault) : address {
        arg0.owner
    }

    public fun remove_wrap(arg0: &mut Vault, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg0.wraps, &arg1), 1);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, vector<u8>>(&mut arg0.wraps, &arg1);
        bump(arg0, arg2);
    }

    public fun save(arg0: &mut Vault, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) <= 262144, 0);
        arg0.data = arg1;
        set_wrap_internal(arg0, arg2, arg3);
        bump(arg0, arg4);
    }

    fun set_wrap_internal(arg0: &mut Vault, arg1: 0x1::string::String, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) <= 262144, 0);
        if (0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg0.wraps, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, vector<u8>>(&mut arg0.wraps, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut arg0.wraps, arg1, arg2);
        };
    }

    public fun version(arg0: &Vault) : u64 {
        arg0.version
    }

    public fun wrap(arg0: &Vault, arg1: 0x1::string::String) : vector<u8> {
        *0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg0.wraps, &arg1)
    }

    // decompiled from Move bytecode v7
}

