module 0x52300702c0fcd741c9c75fd65d35add8b618fece0547145b19f7aa59070686a9::suijerry {
    struct SUIJERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJERRY>(arg0, 6, b"SUIJERRY", b"SUI AND JERRY", b"Welcome to the World of SuiJerry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidfhth7utjyprxqqejzrnmh5rfn4v5ltwy6zg4ht6phxacd5jxeka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIJERRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

