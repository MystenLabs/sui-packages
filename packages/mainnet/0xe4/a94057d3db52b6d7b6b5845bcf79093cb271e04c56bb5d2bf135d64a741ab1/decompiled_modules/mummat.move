module 0xe4a94057d3db52b6d7b6b5845bcf79093cb271e04c56bb5d2bf135d64a741ab1::mummat {
    struct MUMMAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMMAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMMAT>(arg0, 6, b"MUMMAT", b"Sui Mummat", b"Mummat explorers unite! Together, were discovering new paths and creating a vibrant community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016415_1a39d7efad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMMAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMMAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

