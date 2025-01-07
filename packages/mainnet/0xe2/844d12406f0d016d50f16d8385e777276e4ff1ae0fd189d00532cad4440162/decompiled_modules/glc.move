module 0xe2844d12406f0d016d50f16d8385e777276e4ff1ae0fd189d00532cad4440162::glc {
    struct GLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLC>(arg0, 9, b"GLC", b"Goldcoin", b"Goldcoin is the first Digital Gold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/49/standard/newlogo_trans_sm.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GLC>(&mut v2, 1145655655000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

