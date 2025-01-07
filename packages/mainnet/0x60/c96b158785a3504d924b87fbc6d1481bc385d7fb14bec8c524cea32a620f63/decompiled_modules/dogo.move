module 0x60c96b158785a3504d924b87fbc6d1481bc385d7fb14bec8c524cea32a620f63::dogo {
    struct DOGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGO>(arg0, 6, b"DOGO", b"Dogo", b"$DOGO is the coolest dog on the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_e37245db35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

