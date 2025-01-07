module 0x423592d68a3d6078b537ca659920d9044aa76b40453b771b418e0509b61fcce::awk {
    struct AWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWK>(arg0, 9, b"AWK", b"AwkFace", b"Memecoin for bringing you laugh.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5915377-cc3b-42f4-87dc-83100eb2cf81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

