module 0x81e7bed5164bcac7b9e0c84af77fd247e3a03acdb29fe91ebb58716eb19d307d::dyb {
    struct DYB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYB>(arg0, 9, b"DYB", b"ladybug", b"fat and beautiful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8410501c-46da-4be4-80d0-649ca0473223.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYB>>(v1);
    }

    // decompiled from Move bytecode v6
}

