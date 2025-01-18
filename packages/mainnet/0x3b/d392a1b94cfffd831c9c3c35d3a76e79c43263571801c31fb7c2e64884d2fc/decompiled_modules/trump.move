module 0x3bd392a1b94cfffd831c9c3c35d3a76e79c43263571801c31fb7c2e64884d2fc::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"REALTRUMP", b" Official Trump Meme on SUI is HERE! Its time to celebrate everything we stand for: WINNING!  GET YOUR $TRUMP NOW. Go to http://gettrumpmemes.com  Have Fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ghivrl_DWAAA_7_Ex3_3d78fc92b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

