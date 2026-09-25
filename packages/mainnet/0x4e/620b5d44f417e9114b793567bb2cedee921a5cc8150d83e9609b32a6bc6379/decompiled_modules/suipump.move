module 0x4e620b5d44f417e9114b793567bb2cedee921a5cc8150d83e9609b32a6bc6379::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0657494e4e45520a57696e6e657220737569cc01496d2077696e6e65722066726d20424e42f09f9fa1205375692070756d70696e67206872642026206465636964656420746f2074657374206c61756e63686564206d79206f776e20746f6b656e2077696e6e657220636865636b206d7920782061636e7420692070696e6e65647c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f546561737065616b696e67636f6d6d756e697479222c2274776974746572223a2268747470733a2f2f782e636f6d2f676f6f646c75636b79313131303f733d3131227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f39646233383438376563616362653739616334623564303262643230613536382e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

