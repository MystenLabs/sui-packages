module 0xbbcc03a6aa958d9818e7223d5a1067ffdf3df41663d56e4787699fde55594c91::suizo {
    struct SUIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZO>(arg0, 6, b"SUIZO", b"SchizoGirlsOnSuiBlockchain", b"Just a Schizo Girl On Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/schizo_3607fe735c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

