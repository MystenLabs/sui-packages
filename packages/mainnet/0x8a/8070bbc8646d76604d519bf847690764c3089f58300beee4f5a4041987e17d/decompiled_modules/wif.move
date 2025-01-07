module 0x8a8070bbc8646d76604d519bf847690764c3089f58300beee4f5a4041987e17d::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 6, b"WIF", b"WIF ON SUI", b"First dog wif hat, Hitting milstones", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wif_48bd904512.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

