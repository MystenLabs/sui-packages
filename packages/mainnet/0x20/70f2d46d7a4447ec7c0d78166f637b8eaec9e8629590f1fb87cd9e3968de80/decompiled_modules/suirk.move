module 0x2070f2d46d7a4447ec7c0d78166f637b8eaec9e8629590f1fb87cd9e3968de80::suirk {
    struct SUIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRK>(arg0, 6, b"Suirk", b"suirk", b"The Coolest Shark on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23_c2f3492906_0b6cd6f9cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

