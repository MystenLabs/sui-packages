module 0x9b806a5f0769a2a8c1d0ad149c840fac875ff5b071c44200786dd5fde5132ae9::chenk {
    struct CHENK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENK>(arg0, 6, b"CHENK", b"Chenk", b"Even Chenk iz an legen in teh crypto space, a master of none, nd teh kinda guy who probbly misplaced teh priv8 keys 2 ur wallet. But hey, hes here 2 lead teh way in teh memecoinrevlulution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Even_fa2de4646b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHENK>>(v1);
    }

    // decompiled from Move bytecode v6
}

