module 0x57d8321d05cebe43ce3d352be4b86c2630f276fdbbb72f08d9b9cd2ec47aaf50::sanan {
    struct SANAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANAN>(arg0, 6, b"SANAN", b"Sanan on Sui", b" $SANAN is like an experiment, learning from the story of SHIBA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_768x768_5464ed6a2d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

