module 0x4bfe5029b02f5c32265979fafe31caa430fccb576757a9101df256760efa65c1::chi {
    struct CHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHI>(arg0, 9, b"CHI", b"ChiPi", b"chipi chipi chapa chapa cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17729614-80e0-42cc-9a5a-3edb5556731f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

