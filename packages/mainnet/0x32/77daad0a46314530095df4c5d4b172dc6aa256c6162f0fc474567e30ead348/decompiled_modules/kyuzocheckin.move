module 0x3277daad0a46314530095df4c5d4b172dc6aa256c6162f0fc474567e30ead348::kyuzocheckin {
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

    public fun checkin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CheckinEvent{user: 0x2::tx_context::sender(arg0)};
        0x2::event::emit<CheckinEvent>(v0);
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

