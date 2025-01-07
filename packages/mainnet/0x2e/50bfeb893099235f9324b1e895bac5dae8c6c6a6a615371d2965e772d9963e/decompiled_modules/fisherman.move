module 0x2e50bfeb893099235f9324b1e895bac5dae8c6c6a6a615371d2965e772d9963e::fisherman {
    struct FISHERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHERMAN>(arg0, 5, b"FISHERMAN", b"Just a chill fisherman", b"A fisherman with an ambition of catching whales on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1861363398291984384/QmbW9QMZ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISHERMAN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHERMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

