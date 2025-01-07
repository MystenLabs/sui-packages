module 0x4708a6cdce1b2b097660b5630e94277767261bc0abcef2747c2ecc4c886d584b::csi {
    struct CSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSI>(arg0, 6, b"CSI", b"CSI888 ON SUI", b"$CSI: 888 traders stormed the Shanghai Exchange, slapped lucky 8s together, and declared it the future of finance. *Not affiliated with China Securities Index", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ufo_W7_D6y_400x400_0c1fb2d060.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

