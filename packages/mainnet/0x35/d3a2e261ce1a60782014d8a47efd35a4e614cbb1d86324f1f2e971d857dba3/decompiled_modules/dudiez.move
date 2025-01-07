module 0x35d3a2e261ce1a60782014d8a47efd35a4e614cbb1d86324f1f2e971d857dba3::dudiez {
    struct DUDIEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDIEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDIEZ>(arg0, 6, b"DUDIEZ", b"Dudiez meme token", x"42756e6368206f662044756469655a2077686f2062726f6b6520746865697220726f70652061726520726561647920746f206d657373207468696e6773207570206f6e205355492e0a54686520746f6b656e20697320666f722074686520636f6d6d756e6974792c20616e6420492068617665206372656174656420612077656273697465206d7973656c662c2077697468206e6f2054656c656772616d206f7220582e20576879206e6f742063726561746520612043544f20666f722044554449455a2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_20_at_12_52_46a_pm_354806d102.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDIEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUDIEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

