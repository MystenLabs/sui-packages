module 0xc3b61769534cad073dc3eb1c5904daa7ed112e89d0d5f2b0afe754d02b11ce42::mallar {
    struct MALLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALLAR>(arg0, 6, b"Mallar", b"The Mallar dOrder", b"What you are participating in is not just a game, but also a battle for us in SUI. Look forward to it, we will give it a new meaning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sf_Be_Shu2_400x400_17dcb265db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MALLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

