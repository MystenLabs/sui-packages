module 0x22461669731aeaac6766825d5e38534daf5bd31265cddbd1e946cb545045137b::foldi {
    struct FOLDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOLDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOLDI>(arg0, 6, b"FOLDI", b"FOLDI AI-CAT", b"Fold into the future with  Cat $Foldi Token. AI-powered NFT art that's purr-fectly unique.  Collect, trade, and showcase your digital feline masterpieces today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024509_ec9f836849.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOLDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOLDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

