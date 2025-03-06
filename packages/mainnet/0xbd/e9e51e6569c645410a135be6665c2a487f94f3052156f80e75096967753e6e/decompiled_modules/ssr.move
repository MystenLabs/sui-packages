module 0xbde9e51e6569c645410a135be6665c2a487f94f3052156f80e75096967753e6e::ssr {
    struct SSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSR>(arg0, 6, b"SSR", b"Strategic Sui Reserve", b"https://x.com/WatcherGuru/status/1897650350716281175", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_a8dfd6bf29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

