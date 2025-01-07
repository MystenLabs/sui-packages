module 0xa1a5ffeb4c05ded2a67b83f0a4dab89e82c7a21e93401db31e82bdacf520a3a::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 9, b"WHALE", b"Chill Whale", b"$WHALE where power meets limitless opportunity!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1871598653174878208/CZ7imiE__400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHALE>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

