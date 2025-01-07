module 0x6d08e31473e71801ce646acbdc24a22c54ada358ef2be256d06ea2c2d9999b3::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 9, b"CAT", b"Simons Cat", b"A hangry but lovable Sui Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1818648009560698880/W1Xr6uJg_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

