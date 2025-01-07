module 0x581550c2d707c33515ab1c18c9c2d892de7a077204c266a7137b9d6b10dc459::kami {
    struct KAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMI>(arg0, 9, b"KAMI", b"Omikami ", b"To flip shib", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9e331ee-cb1b-4f86-9fc3-64cf9276a323.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

