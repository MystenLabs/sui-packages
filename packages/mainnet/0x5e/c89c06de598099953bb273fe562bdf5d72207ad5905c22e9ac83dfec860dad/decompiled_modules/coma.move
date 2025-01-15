module 0x5ec89c06de598099953bb273fe562bdf5d72207ad5905c22e9ac83dfec860dad::coma {
    struct COMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMA>(arg0, 6, b"COMA", b"Collection of memes Ai", b"Bringing memes out of Ai commmmmmmmmmmmmaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000073478_f44be3db70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

