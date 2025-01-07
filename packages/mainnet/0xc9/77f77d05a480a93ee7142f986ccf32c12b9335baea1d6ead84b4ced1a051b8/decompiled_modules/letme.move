module 0xc977f77d05a480a93ee7142f986ccf32c12b9335baea1d6ead84b4ced1a051b8::letme {
    struct LETME has drop {
        dummy_field: bool,
    }

    fun init(arg0: LETME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LETME>(arg0, 6, b"LETME", b"Letme sui dog", b"let me be the number one dog in memecoin sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052737_bdb7dad8f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LETME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LETME>>(v1);
    }

    // decompiled from Move bytecode v6
}

