module 0x8a5ac8c08767d06ae4a4e08fa6e4fe7f009c20521825b92aa293784eafa4e774::kioskless {
    struct KIOSKLESS has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    public fun register_bridge<T0: store + key>(arg0: &mut Store, arg1: &mut 0x63dfbb58796c0b8caa2f7943a4774000f7339c03733571917944e22e6fc4b710::tradeport_bridge::Manager, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        0x63dfbb58796c0b8caa2f7943a4774000f7339c03733571917944e22e6fc4b710::tradeport_bridge::register_bridge<T0, KIOSKLESS>(arg1, 0x2::coin::mint<KIOSKLESS>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::TreasuryCap<KIOSKLESS>>(&mut arg0.id, 0x1::ascii::string(b"coin_treasury_cap")), 1000000000000000000, arg2), arg2);
    }

    public fun register_bridge_with_signature<T0: store + key>(arg0: &mut Store, arg1: &mut 0x63dfbb58796c0b8caa2f7943a4774000f7339c03733571917944e22e6fc4b710::tradeport_bridge::Manager, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        0x63dfbb58796c0b8caa2f7943a4774000f7339c03733571917944e22e6fc4b710::tradeport_bridge::register_bridge_with_signature<T0, KIOSKLESS>(arg1, arg2, 0x2::coin::mint<KIOSKLESS>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::TreasuryCap<KIOSKLESS>>(&mut arg0.id, 0x1::ascii::string(b"coin_treasury_cap")), 1000000000000000000, arg4), arg3, arg4);
    }

    fun init(arg0: KIOSKLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<KIOSKLESS>(arg0, 9, b"KIOSKLESS", b"Kioskless", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), true, arg1);
        let v3 = Store{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIOSKLESS>>(v2);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::TreasuryCap<KIOSKLESS>>(&mut v3.id, 0x1::ascii::string(b"coin_treasury_cap"), v0);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::DenyCapV2<KIOSKLESS>>(&mut v3.id, 0x1::ascii::string(b"coin_deny_cap"), v1);
        0x2::transfer::share_object<Store>(v3);
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 1, 1);
    }

    // decompiled from Move bytecode v6
}

