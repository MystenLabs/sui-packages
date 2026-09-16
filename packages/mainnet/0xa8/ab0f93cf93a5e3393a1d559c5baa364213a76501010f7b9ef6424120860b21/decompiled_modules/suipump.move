module 0xa8ab0f93cf93a5e3393a1d559c5baa364213a76501010f7b9ef6424120860b21::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"065452454e4348134144454e495949205452454e4348204d4f44458d015945532c20692077696c6c20626520696e20746865207472656e63686573207769746820796f752067757973f09faa96f09f94a57c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f456d616e4162696f2f7374617475732f32303939393938343437313933343234313539222c2277656273697465223a2273756970756d702e6f7267227d2068747470733a2f2f692e696d6775722e636f6d2f754e33486351512e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

