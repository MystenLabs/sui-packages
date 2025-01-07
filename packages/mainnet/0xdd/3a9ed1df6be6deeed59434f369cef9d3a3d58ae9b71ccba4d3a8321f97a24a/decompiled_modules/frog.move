module 0xdd3a9ed1df6be6deeed59434f369cef9d3a3d58ae9b71ccba4d3a8321f97a24a::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 9, b"FROG", b"FROG", b"Majestic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/736x/00/c0/6d/00c06d2d9e8062e493750791b9ade7d3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FROG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

