module 0x7aa21232317dd1b3ae7ea4b5f9649fef6888667c04ae7b7a1e15dbbb31eca3d9::pend {
    struct PEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEND>(arg0, 9, b"PEND", b"vebe", b" xnwn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b48085f-a946-4ee9-8421-2094ee10184e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

