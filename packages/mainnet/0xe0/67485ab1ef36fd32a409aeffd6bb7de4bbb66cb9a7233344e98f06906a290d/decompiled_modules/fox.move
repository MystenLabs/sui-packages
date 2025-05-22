module 0xe067485ab1ef36fd32a409aeffd6bb7de4bbb66cb9a7233344e98f06906a290d::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"FOXY COIN", b"SEXY FOX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747929390111.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

