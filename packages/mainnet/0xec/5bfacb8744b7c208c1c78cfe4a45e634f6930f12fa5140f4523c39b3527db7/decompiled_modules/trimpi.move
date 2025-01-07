module 0xec5bfacb8744b7c208c1c78cfe4a45e634f6930f12fa5140f4523c39b3527db7::trimpi {
    struct TRIMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIMPI>(arg0, 9, b"TRIMPI", b"Trump", b"President of America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47ca084b-46e4-4877-8794-dcb104a677f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

