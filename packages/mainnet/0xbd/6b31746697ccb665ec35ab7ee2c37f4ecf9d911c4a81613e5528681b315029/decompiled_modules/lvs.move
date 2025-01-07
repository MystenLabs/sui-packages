module 0xbd6b31746697ccb665ec35ab7ee2c37f4ecf9d911c4a81613e5528681b315029::lvs {
    struct LVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LVS>(arg0, 9, b"LVS", b"myloveis", b"love each other", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ec8a0ff-e18b-4a7c-9951-205985af7b86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LVS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LVS>>(v1);
    }

    // decompiled from Move bytecode v6
}

