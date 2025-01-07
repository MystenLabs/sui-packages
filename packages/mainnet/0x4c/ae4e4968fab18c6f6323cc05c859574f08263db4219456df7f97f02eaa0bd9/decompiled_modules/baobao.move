module 0x4cae4e4968fab18c6f6323cc05c859574f08263db4219456df7f97f02eaa0bd9::baobao {
    struct BAOBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAOBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAOBAO>(arg0, 9, b"BAOBAO", b"baobao", b"baobaopump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/625c032a-ac5f-4554-ba46-5ddc0c239aed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAOBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAOBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

