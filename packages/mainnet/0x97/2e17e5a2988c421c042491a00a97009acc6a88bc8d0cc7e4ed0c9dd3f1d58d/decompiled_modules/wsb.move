module 0x972e17e5a2988c421c042491a00a97009acc6a88bc8d0cc7e4ed0c9dd3f1d58d::wsb {
    struct WSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSB>(arg0, 6, b"WSB", b"Wall Sui's Bets", x"546865206d656d65636f696e20706f7765726564206279207468652053756920626c6f636b636861696e2e2044726976656e20627920636f6d6d756e6974792c206675656c6564206279206d656d65732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wall_Sui_s_Bets_0f3a05cf19.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

