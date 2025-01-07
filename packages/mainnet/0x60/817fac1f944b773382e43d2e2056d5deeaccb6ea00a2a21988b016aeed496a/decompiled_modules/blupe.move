module 0x60817fac1f944b773382e43d2e2056d5deeaccb6ea00a2a21988b016aeed496a::blupe {
    struct BLUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUPE>(arg0, 6, b"Blupe", b"Bluepepe Sui", b"Blu better than green!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blupepe_04c2d670d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

