module 0x9ec92181bccec924e1e58cbb16fbca81a0c734511dab2a09f5e80ea6b6ffa009::pipi {
    struct PIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPI>(arg0, 6, b"PIPI", b"pipi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"pipi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIPI>(&mut v2, 516198912000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

