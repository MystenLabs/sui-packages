module 0x19ae26ca48a60da21641ca2d46e4aee0700518d85bd51c9514019865df3b28d3::wif {
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

