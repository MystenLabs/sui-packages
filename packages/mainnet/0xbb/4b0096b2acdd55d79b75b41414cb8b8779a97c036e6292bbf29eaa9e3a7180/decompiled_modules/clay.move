module 0xbb4b0096b2acdd55d79b75b41414cb8b8779a97c036e6292bbf29eaa9e3a7180::clay {
    struct CLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAY>(arg0, 6, b"CLAY", b"ClaySui", b"Claysui is a blue of SUI with its own community token $CLAY. It aims to unite SuiNetwork and memecoin lovers to grow the ecosystem together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifki6azrtpbrl72f44xn6iijfmlkwe3ltflskyx4h3cr6jmd2k4hq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

