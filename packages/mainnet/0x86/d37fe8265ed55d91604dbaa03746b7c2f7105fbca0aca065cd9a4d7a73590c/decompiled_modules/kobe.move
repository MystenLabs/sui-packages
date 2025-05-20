module 0x86d37fe8265ed55d91604dbaa03746b7c2f7105fbca0aca065cd9a4d7a73590c::kobe {
    struct KOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBE>(arg0, 6, b"KOBE", b"Kobe Coin", x"53746570206261636b2e2046616465617761792e2042616e6b2069742e0a244b4f42452069736e2774206a75737420616e6f74686572206d656d6520636f696e2e0a4974277320323420686f757273206f66206772696e642c203820686f757273206f6620736c65657020e2809420616e64207a65726f20657863757365732e0a4d616d6261204d656e74616c6974792c206f6e2d636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747699855081.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

