module 0x1d3d2e9a33dd009254068b154c3539be4259833f219993ab00dbbcfd2e2d4e05::kyuzocheckin {
    struct HouseData has key {
        id: 0x2::object::UID,
        admin: address,
        sig_pub_key: vector<u8>,
    }

    struct KYUZOCHECKIN has drop {
        dummy_field: bool,
    }

    struct CheckinEvent has copy, drop {
        user: address,
    }

    public fun admin(arg0: &HouseData) : address {
        arg0.admin
    }

    public fun checkin(arg0: &HouseData, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg0.sig_pub_key)) {
            let v0 = 0x2::tx_context::sender(arg3);
            let v1 = 0x2::bcs::to_bytes<address>(&v0);
            0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
            0x2::ecdsa_k1::secp256k1_verify(&arg1, &arg0.sig_pub_key, &v1, 1);
        };
        let v2 = CheckinEvent{user: 0x2::tx_context::sender(arg3)};
        0x2::event::emit<CheckinEvent>(v2);
    }

    fun init(arg0: KYUZOCHECKIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<KYUZOCHECKIN>(arg0, arg1);
        let v0 = HouseData{
            id          : 0x2::object::new(arg1),
            admin       : 0x2::tx_context::sender(arg1),
            sig_pub_key : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<HouseData>(v0);
    }

    public fun sig_pub_key(arg0: &HouseData) : vector<u8> {
        arg0.sig_pub_key
    }

    public fun transfer_admin(arg0: &mut HouseData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public fun update_sig_pub_key(arg0: &mut HouseData, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.sig_pub_key = arg1;
    }

    // decompiled from Move bytecode v6
}

