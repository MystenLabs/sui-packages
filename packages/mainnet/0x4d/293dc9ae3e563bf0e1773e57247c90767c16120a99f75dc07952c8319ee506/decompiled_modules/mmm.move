module 0x4d293dc9ae3e563bf0e1773e57247c90767c16120a99f75dc07952c8319ee506::mmm {
    struct MMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMM>(arg0, 6, b"MMM", b"MMM2049", x"5468652077686f6c652063727970746f206973206120707972616d69642e2045786365707420244d4d4d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_Kuwnzzk_400x400_d8dfb60c3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

