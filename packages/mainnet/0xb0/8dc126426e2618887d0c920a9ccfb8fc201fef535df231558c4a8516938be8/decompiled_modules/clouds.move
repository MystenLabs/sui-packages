module 0xb08dc126426e2618887d0c920a9ccfb8fc201fef535df231558c4a8516938be8::clouds {
    struct CLOUDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOUDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUDS>(arg0, 6, b"CLOUDS", b"Clouds", b"Meme going wild", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730657902395.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOUDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

