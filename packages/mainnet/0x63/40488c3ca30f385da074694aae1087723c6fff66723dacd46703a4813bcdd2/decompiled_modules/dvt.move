module 0x6340488c3ca30f385da074694aae1087723c6fff66723dacd46703a4813bcdd2::dvt {
    struct DVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DVT>(arg0, 9, b"DVT", x"56c4836e20747579e1babf6e", b"D.v.t", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a61237af-e590-4e16-ba8c-a17616e946dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

