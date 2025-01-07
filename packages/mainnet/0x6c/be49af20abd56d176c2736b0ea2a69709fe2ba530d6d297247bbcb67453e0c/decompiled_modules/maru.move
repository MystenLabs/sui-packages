module 0x6cbe49af20abd56d176c2736b0ea2a69709fe2ba530d6d297247bbcb67453e0c::maru {
    struct MARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARU>(arg0, 6, b"MARU", b"MARU ON SUI", b"Introducing $MARUU: The Meme Coin Thats Purr-fectly Boxed! Hey, crypto enthusiasts and cat lovers on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MARU_4135489f71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

