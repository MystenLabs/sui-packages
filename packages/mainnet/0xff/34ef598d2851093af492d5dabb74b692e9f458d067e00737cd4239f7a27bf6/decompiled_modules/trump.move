module 0xff34ef598d2851093af492d5dabb74b692e9f458d067e00737cd4239f7a27bf6::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"TRUMP Official meme on SUI", b"My NEW Official Trump Meme is HERE! Its time to celebrate everything we stand for: WINNING! Join my very special Trump Community. GET YOUR $TRUMP NOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trump_6f7c39b4d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

