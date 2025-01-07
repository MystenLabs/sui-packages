module 0x7ba7a1c20716a834fc3622efafdd38187628efd2db9822fa2b8b2fe37a37b508::fam {
    struct FAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAM>(arg0, 6, b"FAM", b"Fatqua Man", b"The man that rolls on the waves of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fatman_641bfae988.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

