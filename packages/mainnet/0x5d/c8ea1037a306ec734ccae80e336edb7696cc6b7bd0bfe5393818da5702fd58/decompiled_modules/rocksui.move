module 0x5dc8ea1037a306ec734ccae80e336edb7696cc6b7bd0bfe5393818da5702fd58::rocksui {
    struct ROCKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKSUI>(arg0, 6, b"ROCKSUI", b"ROCKO ON SUI", x"24524f434b53554920212041206b6e6f636b6f757420200a70756e636820696e2074686520200a6d656d6520636f696e20776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wild_8ccf3df735.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

