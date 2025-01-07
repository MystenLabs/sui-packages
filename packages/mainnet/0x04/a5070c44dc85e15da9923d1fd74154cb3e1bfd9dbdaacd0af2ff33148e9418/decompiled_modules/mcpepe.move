module 0x4a5070c44dc85e15da9923d1fd74154cb3e1bfd9dbdaacd0af2ff33148e9418::mcpepe {
    struct MCPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCPEPE>(arg0, 6, b"MCPEPE", b"MCPEPE Sui", b"$MCPEPE  Is a community - driven cryptocurancy build around the theme of playful and mischievous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241007_153409_278e9d50f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

