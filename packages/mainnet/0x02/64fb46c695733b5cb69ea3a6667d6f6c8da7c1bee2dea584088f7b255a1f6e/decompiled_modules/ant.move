module 0x264fb46c695733b5cb69ea3a6667d6f6c8da7c1bee2dea584088f7b255a1f6e::ant {
    struct ANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANT>(arg0, 9, b"ANT", b"Antcoin", b"O lazy person, go to the ant, pay attention to its behavior and be wise! It has no leader, overseer or ruler, but it stores up its supplies in the summer and gathers its food at harvest time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ebf05a4-cafc-4199-ada5-e6f3f0942c1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

