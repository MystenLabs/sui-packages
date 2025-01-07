module 0x525c214dfd40e9a8e4a7a4489772697b791e662c28ff9c3265cef3258aa5d992::chomp {
    struct CHOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMP>(arg0, 6, b"CHOMP", b"ChompCoin", x"43686f6d70206973205355492773206669657263657374206c6974746c652066757a7a62616c6c21204f72616e676520697320746865206e657720626c75652c20736f20626520776974682075732c20616e64204c65747475636520436f6f6b210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ktz_E_Jz_Ki_400x400_91410e8f7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

