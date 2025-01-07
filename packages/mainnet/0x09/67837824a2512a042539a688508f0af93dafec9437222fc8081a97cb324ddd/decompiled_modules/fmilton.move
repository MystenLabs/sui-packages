module 0x967837824a2512a042539a688508f0af93dafec9437222fc8081a97cb324ddd::fmilton {
    struct FMILTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMILTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMILTON>(arg0, 9, b"FMILTON", b"FUCK MILTON", b"SUI FUCI MILTON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/F9yiB9kPzCQKE8vP9jZfHXXuTL9z1FKTaZvqqKXdpump.png?size=lg&key=08bb7c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FMILTON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMILTON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMILTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

