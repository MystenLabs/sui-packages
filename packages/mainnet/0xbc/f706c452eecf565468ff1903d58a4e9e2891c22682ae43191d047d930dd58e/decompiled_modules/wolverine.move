module 0xbcf706c452eecf565468ff1903d58a4e9e2891c22682ae43191d047d930dd58e::wolverine {
    struct WOLVERINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLVERINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLVERINE>(arg0, 9, b"WOLVERINE", b"wolverine", b"Logan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/066409b3-d257-4b0a-b6bf-f91f0323914f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLVERINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOLVERINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

