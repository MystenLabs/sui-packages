module 0x590958868bfa0f6d8c99495e28d49c630a702ffa113496efc1ef17a536bf9a4a::milka {
    struct MILKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILKA>(arg0, 6, b"MILKA", b"Sui Milka", b"MILKA is cooking to bring a massive wave on $SUI Dont be a small bull, be a big bull MILKA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040087_968c84d530.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

