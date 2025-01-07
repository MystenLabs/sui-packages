module 0x426cf27ab47cedf5f2cb3cd110090223b77074a9ba1c798c2577b4c93341c8d1::fepe {
    struct FEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEPE>(arg0, 6, b"FEPE", b"Fepe", x"455045202846455045290a544845204348494c4c4553542050454e4755494e20494e2054484520574f524c44202068747470733a2f2f742e6d652f4645504554484546494e414c50454e4755494e205765623a20464550452e76697020547769747465723a2068747470733a2f2f782e636f6d2f466570655f4f6e536f6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/563456_c3e1b88fc0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

