module 0xd620a2add96843669cdb5063f840d3193ce3afdbfac55d75f1673010a1c98e06::yourmon {
    struct YOURMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOURMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOURMON>(arg0, 6, b"YOURMON", b"YOUR MOM", b"To all the solana memecoin degens spamming my mentions. I have one pet and it's name is your mom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000226444_082c1dfecf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOURMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOURMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

