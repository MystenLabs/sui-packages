module 0xc705674d1c7e9cda6be2b684d4ab2d0f84f7e4bedbb5211c10a389e5cb558239::cucu {
    struct CUCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCU>(arg0, 9, b"CUCU", b"Cucurut", b"Future memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0df39c9d-361c-457b-9e2e-7813f63c4bbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUCU>>(v1);
    }

    // decompiled from Move bytecode v6
}

