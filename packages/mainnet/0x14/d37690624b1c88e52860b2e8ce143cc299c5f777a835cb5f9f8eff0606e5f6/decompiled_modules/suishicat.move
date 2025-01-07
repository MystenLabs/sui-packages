module 0x14d37690624b1c88e52860b2e8ce143cc299c5f777a835cb5f9f8eff0606e5f6::suishicat {
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

