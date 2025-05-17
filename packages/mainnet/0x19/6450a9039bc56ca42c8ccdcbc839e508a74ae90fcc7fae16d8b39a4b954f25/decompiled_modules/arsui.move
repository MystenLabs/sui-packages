module 0x196450a9039bc56ca42c8ccdcbc839e508a74ae90fcc7fae16d8b39a4b954f25::arsui {
    struct ARSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARSUI>(arg0, 6, b"ARSUI", b"ARENA SUI", b"FIRST AREBA SOCIAL ABOUT SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigqlsdffgueholmm3seyrtym3xlzy242tzuuaip6kgygqapivjgne")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

