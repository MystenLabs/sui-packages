module 0x667e08a362cf40621d7076e388e8cdab9d3e6c6884d2c0b4f90e6eef0c86944f::anna {
    struct ANNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANNA>(arg0, 9, b"ANNA", b"Anna Bannana", b"ANNA is not meme it's a cult", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1689570040331526144/khffBFfd.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANNA>(&mut v2, 223000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANNA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

