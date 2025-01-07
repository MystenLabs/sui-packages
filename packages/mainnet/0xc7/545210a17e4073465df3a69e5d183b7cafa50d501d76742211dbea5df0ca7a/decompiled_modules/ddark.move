module 0xc7545210a17e4073465df3a69e5d183b7cafa50d501d76742211dbea5df0ca7a::ddark {
    struct DDARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDARK>(arg0, 9, b"DDARK", b"DARK", b"DARKES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4da9258-f5cc-4286-89a9-1b1e50f814a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

