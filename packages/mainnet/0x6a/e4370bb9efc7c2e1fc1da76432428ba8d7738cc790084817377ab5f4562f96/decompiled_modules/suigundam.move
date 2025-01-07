module 0x6ae4370bb9efc7c2e1fc1da76432428ba8d7738cc790084817377ab5f4562f96::suigundam {
    struct SUIGUNDAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUNDAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUNDAM>(arg0, 6, b"SUIGUNDAM", b"SUI GUNDAM", b"SIMPLE AS THAT, A GUNDAM ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_9_ef07ad189a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUNDAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGUNDAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

