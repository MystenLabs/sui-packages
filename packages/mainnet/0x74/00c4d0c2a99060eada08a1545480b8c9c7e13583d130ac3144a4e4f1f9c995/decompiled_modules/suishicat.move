module 0x7400c4d0c2a99060eada08a1545480b8c9c7e13583d130ac3144a4e4f1f9c995::suishicat {
    struct SUISHICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHICAT>(arg0, 9, b"SUISHICAT", b"Suishi Cat", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISHICAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHICAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

