module 0xdb01e9f06e7fec75b17dadc7db54b6f55fd051f9ee027f7ce0f72d360a8ec707::digitalco {
    struct DIGITALCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGITALCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIGITALCO>(arg0, 9, b"DIGITALCO", b"Digital", b"Super coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/394274f0-192e-42de-88d0-5364698cacf4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGITALCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIGITALCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

