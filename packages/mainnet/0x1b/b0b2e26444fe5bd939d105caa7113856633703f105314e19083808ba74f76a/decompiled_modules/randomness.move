module 0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::randomness {
    struct Randomness has store, key {
        id: 0x2::object::UID,
        client_seed: vector<u8>,
        server_seed_pk: vector<u8>,
        version: u64,
        nonce: u64,
    }

    struct RandomnessManage has store, key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        nonce: u64,
    }

    struct Revealed has copy, drop {
        randomness_id: 0x2::object::ID,
        version: u64,
        nonce: u64,
        server_seed_pk: vector<u8>,
    }

    struct ClientSeedChanged has copy, drop {
        randomness_id: 0x2::object::ID,
        version: u64,
        nonce: u64,
        new_client_seed: vector<u8>,
    }

    public fun new(arg0: &mut RandomnessManage, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : Randomness {
        verify_manage_signature(arg0, arg2, &arg3, arg4);
        Randomness{
            id             : 0x2::object::new(arg4),
            client_seed    : arg1,
            server_seed_pk : arg2,
            version        : 0,
            nonce          : 0,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RandomnessManage{
            id         : 0x2::object::new(arg0),
            public_key : x"a7ae1ee01eaa4315d933c1f761f6ab7ecdd614062149e9c77e342dc9f68ff680",
            nonce      : 0,
        };
        0x2::transfer::share_object<RandomnessManage>(v0);
    }

    public fun reveal(arg0: &mut RandomnessManage, arg1: &mut Randomness, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.server_seed_pk != arg2, 11);
        verify_manage_signature(arg0, arg2, &arg3, arg4);
        let v0 = Revealed{
            randomness_id  : 0x2::object::uid_to_inner(&arg1.id),
            version        : arg1.version,
            nonce          : arg1.nonce,
            server_seed_pk : arg1.server_seed_pk,
        };
        0x2::event::emit<Revealed>(v0);
        arg1.server_seed_pk = arg2;
        arg1.version = arg1.version + 1;
        arg1.nonce = 0;
    }

    public fun set(arg0: &mut Randomness, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.client_seed != arg1, 11);
        let v0 = ClientSeedChanged{
            randomness_id   : 0x2::object::uid_to_inner(&arg0.id),
            version         : arg0.version,
            nonce           : arg0.nonce,
            new_client_seed : arg1,
        };
        0x2::event::emit<ClientSeedChanged>(v0);
        arg0.client_seed = arg1;
    }

    public fun u64_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 >= 10) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((48 + arg0) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun verify_manage_signature(arg0: &mut RandomnessManage, arg1: vector<u8>, arg2: &vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::address::to_bytes(0x2::tx_context::sender(arg3));
        let v1 = &mut v0;
        0x1::vector::append<u8>(v1, arg1);
        0x1::vector::append<u8>(v1, u64_to_bytes(arg0.nonce));
        assert!(0x2::ed25519::ed25519_verify(arg2, &arg0.public_key, v1), 10);
        arg0.nonce = arg0.nonce + 1;
    }

    public fun verify_used(arg0: &mut Randomness, arg1: &mut vector<u8>, arg2: &vector<u8>) {
        0x1::vector::append<u8>(arg1, u64_to_bytes(arg0.version));
        0x1::vector::append<u8>(arg1, u64_to_bytes(arg0.nonce));
        assert!(0x2::ed25519::ed25519_verify(arg2, &arg0.server_seed_pk, arg1), 20);
        arg0.nonce = arg0.nonce + 1;
    }

    // decompiled from Move bytecode v6
}

