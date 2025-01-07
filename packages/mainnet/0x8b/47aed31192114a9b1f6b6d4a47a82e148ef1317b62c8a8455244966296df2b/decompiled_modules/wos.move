module 0x8b47aed31192114a9b1f6b6d4a47a82e148ef1317b62c8a8455244966296df2b::wos {
    struct WOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOS>(arg0, 6, b"WOS", b"Water On Sui", b"#Suis beloved mascot token! Dive into the refreshing world of $WATER, where gains flows!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/15_d8ece9a806.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

