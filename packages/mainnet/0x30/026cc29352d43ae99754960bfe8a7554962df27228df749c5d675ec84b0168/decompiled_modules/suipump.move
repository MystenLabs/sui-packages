module 0x30026cc29352d43ae99754960bfe8a7554962df27228df749c5d675ec84b0168::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"02435508436c65616e2055709e01476f6f64206e6577732e20576520617265207265626f6f74696e6720746865207472656e63686573206f6e20235375692e205374617274696e67207769746820736f6d65206d756368206e656564656420434c45414e55502e20e29c8a7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f656d616e6162696f2f7374617475732f32303938353135303737313936353935333535227d2068747470733a2f2f692e696d6775722e636f6d2f6754646b3656722e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

