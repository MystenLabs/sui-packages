module 0xc8663de46cdca27202d9659274816b9a525e4ac0626ce9384fe3c07e9215aeef::devil {
    struct DEVIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVIL>(arg0, 6, b"Devil", b"Devil PEPE", b"PEPE has turned into a devil and returned from hell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_20_57_48_cfcb6fca2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

