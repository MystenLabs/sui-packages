module 0x8a8a3fa5ad078b5ab0c2ab3c10ab1b3aa165a27625d65a8d57851a3e35e52cf4::fast_car {
    struct FAST_CAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAST_CAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAST_CAR>(arg0, 9, b"MCLAREN", b"fast car", b"really fast small car.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1929938688152064000/x7q1iXGt_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAST_CAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAST_CAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

