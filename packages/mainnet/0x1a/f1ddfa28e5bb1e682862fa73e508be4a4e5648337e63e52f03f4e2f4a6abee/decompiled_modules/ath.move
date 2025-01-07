module 0x1af1ddfa28e5bb1e682862fa73e508be4a4e5648337e63e52f03f4e2f4a6abee::ath {
    struct ATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATH>(arg0, 6, b"ATH", b"ATH 100K", b"ATH 100K BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4c144e85_2a31_412f_9f2d_8299a66cd476_1a53a8cc15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

