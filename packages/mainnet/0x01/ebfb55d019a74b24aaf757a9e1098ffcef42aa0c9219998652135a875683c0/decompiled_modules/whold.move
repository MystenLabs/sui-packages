module 0x1ebfb55d019a74b24aaf757a9e1098ffcef42aa0c9219998652135a875683c0::whold {
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

