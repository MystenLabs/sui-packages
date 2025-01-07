module 0xa202e0f520add0ae272186acf9cb4bc6810541ab5a53721356616aa20e19b55::strm {
    struct STRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRM>(arg0, 6, b"STRM", b"SUITRUMPRUSHMORE", b"A lot of riots in American during the election, but trump managed to win it ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047786_34942112e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

