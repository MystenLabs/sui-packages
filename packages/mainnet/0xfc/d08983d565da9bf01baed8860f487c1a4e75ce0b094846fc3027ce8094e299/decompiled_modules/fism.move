module 0xfcd08983d565da9bf01baed8860f487c1a4e75ce0b094846fc3027ce8094e299::fism {
    struct FISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISM>(arg0, 9, b"FISM", b"Fish Man", b"A Meme for everybody", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45760f11-407f-47dd-9e74-39854da9d138.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

