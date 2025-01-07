module 0x47e00ff5f602486cd09bc36483b36d98b4b85bc16b0525dac3b8f20946876caa::oshi {
    struct OSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSHI>(arg0, 9, b"Oshi", b"Oshi", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OSHI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

