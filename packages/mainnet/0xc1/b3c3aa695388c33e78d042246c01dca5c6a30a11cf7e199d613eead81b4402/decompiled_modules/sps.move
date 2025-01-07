module 0xc1b3c3aa695388c33e78d042246c01dca5c6a30a11cf7e199d613eead81b4402::sps {
    struct SPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPS>(arg0, 9, b"SPS", b"Supercus", b"Sps top1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45311dd2-14e3-4404-89cd-48b3e97408f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

