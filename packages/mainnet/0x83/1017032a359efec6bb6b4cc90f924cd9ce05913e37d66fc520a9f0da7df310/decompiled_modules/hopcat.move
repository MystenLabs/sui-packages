module 0x831017032a359efec6bb6b4cc90f924cd9ce05913e37d66fc520a9f0da7df310::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HOPCAT", b"Hop Cat On Sui", b"First cat on Turbos Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730997991849.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

