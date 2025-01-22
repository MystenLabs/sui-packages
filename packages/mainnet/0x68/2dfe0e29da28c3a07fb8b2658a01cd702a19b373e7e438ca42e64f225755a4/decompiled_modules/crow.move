module 0x682dfe0e29da28c3a07fb8b2658a01cd702a19b373e7e438ca42e64f225755a4::crow {
    struct CROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROW>(arg0, 6, b"CROW", b"SuiCROW", b"If you haven't heard about CROW yet, where ya been? CROW isn't just your average meme, he's a living icon! CROW's contract address is special, just one step away from his friend Phoenix's, which has its own unique identifier! Join CROW, a member of the famous Boy's Club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000200437_0196a9d651.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

