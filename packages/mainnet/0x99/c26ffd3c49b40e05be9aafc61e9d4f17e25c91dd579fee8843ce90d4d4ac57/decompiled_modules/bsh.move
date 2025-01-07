module 0x99c26ffd3c49b40e05be9aafc61e9d4f17e25c91dd579fee8843ce90d4d4ac57::bsh {
    struct BSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSH>(arg0, 9, b"BSH", b"BoomSha", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a810d5f8-96ee-4c3a-af39-1fb6c479c979.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

