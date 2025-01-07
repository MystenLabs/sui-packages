module 0x298f55ea1fd64c91aee0122ef80dd33e32f37b0b9d9b46b72ae9ff39cff3df9e::bbcat {
    struct BBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBCAT>(arg0, 6, b"BBCAT", b"baby cat", b"baby cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/maxresdefault_bfe3bc503f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

