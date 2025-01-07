module 0x44ebc7a0f79943be3498455c9fc3831ab7bfdaca499ef8754093ccc76cc0eb24::eggy {
    struct EGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGY>(arg0, 6, b"EGGY", b"EggyCoin", b"$EGGY, more than just a Meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038894_24e4530d4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

