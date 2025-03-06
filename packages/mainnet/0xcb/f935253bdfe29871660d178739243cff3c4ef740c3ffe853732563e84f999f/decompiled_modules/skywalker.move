module 0xcbf935253bdfe29871660d178739243cff3c4ef740c3ffe853732563e84f999f::skywalker {
    struct SKYWALKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYWALKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYWALKER>(arg0, 9, b"SKYWALKER", b"Mark Hamill", b"Born: September 25, 1951, Oakland, CA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/SKYWALKER.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKYWALKER>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYWALKER>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKYWALKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

