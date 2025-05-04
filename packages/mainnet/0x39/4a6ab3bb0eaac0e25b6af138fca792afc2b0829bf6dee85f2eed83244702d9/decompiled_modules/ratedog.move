module 0x394a6ab3bb0eaac0e25b6af138fca792afc2b0829bf6dee85f2eed83244702d9::ratedog {
    struct RATEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATEDOG>(arg0, 6, b"RATEDOG", b"PIRATE DOG COIN", b"Feel the experience of being an army of ratedogs, together we will rob fishermen and become rulers in the vast seas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ff4ixe_63a8119622.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

