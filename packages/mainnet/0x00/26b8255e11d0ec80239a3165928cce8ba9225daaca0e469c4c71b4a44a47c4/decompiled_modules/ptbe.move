module 0x26b8255e11d0ec80239a3165928cce8ba9225daaca0e469c4c71b4a44a47c4::ptbe {
    struct PTBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTBE>(arg0, 6, b"PTBE", b"PeterSui Todd Blue Eyes", x"0a506574657220546f64642c207468652063726561746f72206f6620426974636f696e2c20686173206869732073696768747320736574206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Peter_Sui_Todd_Blue_Eyes_79aef25725.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

