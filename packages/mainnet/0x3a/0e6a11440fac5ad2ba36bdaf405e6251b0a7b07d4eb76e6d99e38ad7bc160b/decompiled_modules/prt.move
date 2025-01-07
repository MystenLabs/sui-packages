module 0x3a0e6a11440fac5ad2ba36bdaf405e6251b0a7b07d4eb76e6d99e38ad7bc160b::prt {
    struct PRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRT>(arg0, 6, b"PRT", b"PIRATESONSUI", b"\"Sail to freedom on the high sui!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/indir_8a24e325ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

