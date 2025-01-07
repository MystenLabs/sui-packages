module 0x778a8260c8ffc6fe2c11ba53db3bf4bd1ef06929edd7f6aa4db12c3e44127c63::whold {
    struct WHOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHOLD>(arg0, 6, b"WHOLD", b"whold", b"Whold Meme Coin! in life and things we're not sure how much to lose But in $Whold, we'll all turn that Happy memory moment into a golden thing Price", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732248513044.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHOLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

