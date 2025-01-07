module 0xc861c92409c75a4b6aa70cb5ea9645a9ed1bbd69f0c130322c92ce716e4e14cd::hds {
    struct HDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDS>(arg0, 9, b"HDS", b"Hades", b"Hades never die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b22fa6d4-8e3c-4152-a3eb-ad26a7802748.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

