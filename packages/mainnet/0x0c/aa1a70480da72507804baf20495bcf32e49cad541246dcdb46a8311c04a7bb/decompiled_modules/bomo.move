module 0xcaa1a70480da72507804baf20495bcf32e49cad541246dcdb46a8311c04a7bb::bomo {
    struct BOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMO>(arg0, 6, b"BOMO", b"$BOMO", b"$BOMO emerges as the \"Book of Move Pump\" for traders looking to maximize pump potential in the crypto market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_d2619b5ba7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

