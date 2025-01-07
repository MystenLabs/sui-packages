module 0x7b232dbf83bc3a4cf5120805748ff848c398a2829189c0a0593d92a5468fc12c::grmp {
    struct GRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRMP>(arg0, 9, b"GRMP", b"Grumpy Cat", b"Don't worry, be happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca7da10a-d357-4dd6-af34-9199d77dd159.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

