module 0xd05cfdc3081cc8c7898522056e55d0f6a5a01d24040ea9964bd737ff70938a54::flob {
    struct FLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOB>(arg0, 6, b"FLOB", b"Flob", b"Welcome to FLOB  Feeling Lost, Overwhelmed, and Bewildered, where it's okay to be stuck in the blockchain of life or confused about your next transaction. Whether you're holding onto sanity, overwhelmed by market dips, or just trying to decode the smart contract of existence, this is your safe space to mine clarity and connect with like-minded explorers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3453_4da831bd3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

