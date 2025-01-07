module 0xed15b89ccd9775b9c2d65de461b41936504d7876233dacb92ef962dca9301168::neira {
    struct NEIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRA>(arg0, 6, b"NEIRA", b"NEIRASUI", b" $NEIRASUI, Neiro's woman, is arriving to ride the wave of the crypto market on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4449_5a1a9f6781.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

