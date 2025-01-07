module 0x267d9b157276ddcc10f5cccaaa443c753d9c5b89096f3506d29ee0864cfd78d0::suisol {
    struct SUISOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISOL>(arg0, 6, b"SUISOL", b"SuiXSolana", b"just a meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5426_5b29682b9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

