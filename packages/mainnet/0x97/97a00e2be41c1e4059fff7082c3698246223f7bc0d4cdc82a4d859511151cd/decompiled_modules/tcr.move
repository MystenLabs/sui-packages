module 0x9797a00e2be41c1e4059fff7082c3698246223f7bc0d4cdc82a4d859511151cd::tcr {
    struct TCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCR>(arg0, 6, b"TCR", b"Trump cat rider", b"Memes Infrastructure & App for coins to flourish and users to earn. Built on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036670_0bd20e2d63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

