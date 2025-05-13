module 0x690ce730327cd1c942bc50c054ecfd4bf816ff3b87a630f22e186a359a697ad::goonc {
    struct GOONC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOONC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOONC>(arg0, 9, b"GOONC", b"gooncoin", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebjj52eznuxsmc6djnxz3n6dbuhyt44xv42xqlk3kbaoudog64ji")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOONC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOONC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOONC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

