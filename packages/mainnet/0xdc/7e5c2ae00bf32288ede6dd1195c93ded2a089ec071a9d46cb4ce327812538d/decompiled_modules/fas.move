module 0xdc7e5c2ae00bf32288ede6dd1195c93ded2a089ec071a9d46cb4ce327812538d::fas {
    struct FAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAS>(arg0, 9, b"FAS", x"53c38044", b"FG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00ca0278-5ddc-4790-810a-f6820d75a966.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

