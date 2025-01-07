module 0xb0e44775e70bae7162b41c936c88474171ba6d36c61a98446e87c65c14e95e34::ddrg {
    struct DDRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDRG>(arg0, 9, b"DDRG", b"D DRAGON ", x"59656172206f662074686520447261676f6e20f09f90b22e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/438845e3-b87c-4ed6-9d52-14e38b6af1a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

