module 0x48c71331f7d5154fb1b53eed7d310ed2540a52cdc03d4970584a749ce235abba::votex {
    struct VOTEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOTEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOTEX>(arg0, 6, b"VoteX", b"Vote X", b"The one election where everyone is a winner or a meme!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vote_X_54f8938ee1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOTEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOTEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

