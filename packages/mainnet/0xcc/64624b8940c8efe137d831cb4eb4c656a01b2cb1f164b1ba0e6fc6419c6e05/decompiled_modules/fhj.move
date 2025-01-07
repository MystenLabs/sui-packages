module 0xcc64624b8940c8efe137d831cb4eb4c656a01b2cb1f164b1ba0e6fc6419c6e05::fhj {
    struct FHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHJ>(arg0, 9, b"FHJ", b"JHD", b"How to get a good at it for ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53d0e66f-67bb-474d-85df-c3ddc5ab98a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FHJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

