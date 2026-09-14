module 0xa9a54edba76800d298112a19606fa879213ba1e2f6a6ae0209fdd46937d014bf::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"095355495348494341541153616d757261692063617420736861726bea0153616d757261692063617420736861726b202824535549534849434154290a41206d656d65636f696e20666f7267656420696e20686f6e6f722c206f6365616e2077617665732c20616e6420746865206c617a7920737069726974206f6620612073616d75726169206361742d736861726b2e202453554953484920736c69636573207468726f75676820766f6c6174696c697479207769746820697473206b6174616e61207768696c6520726964696e67207468652063727970746f20776176657320776974682074686520636f6f6c2063616c6d206f662061206d6172696e652073686f67756e2e1f68747470733a2f2f692e696d6775722e636f6d2f5930523634536a2e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

