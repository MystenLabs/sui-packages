module 0xac30a66054c5582435e93715f1ddd8cba28225ae0afec60c5dbddf454da1e6e1::awaw {
    struct AWAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAW>(arg0, 9, b"AWAW", b"Awawaw", b"Awawawawa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3224f206-ee3d-481b-b54c-868da5878417.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

