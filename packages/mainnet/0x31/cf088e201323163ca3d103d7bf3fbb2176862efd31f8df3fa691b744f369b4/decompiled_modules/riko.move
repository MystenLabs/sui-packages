module 0x31cf088e201323163ca3d103d7bf3fbb2176862efd31f8df3fa691b744f369b4::riko {
    struct RIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIKO>(arg0, 6, b"RIKO", b"RIKO SUI", x"536f2c207768656e2052696b6f20776173206a7573742061206c6974746c65206b696420776974682062696720647265616d732e2e2e204576657279206c6567656e642073746172747320736f6d6577686572652c2072696768743f204576656e2061732061206b69642c2052696b6f206b6e65772068652077617320676f696e6720746f20626520736f6d656f6e65207370656369616c2e202452494b4f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hihihihihihih_1080b1b5ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

