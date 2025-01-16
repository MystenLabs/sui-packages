module 0x3a5e38795cd3d19516cad050bdf99731139af02777f19cf1df66ffccfe9d2ca4::fgs {
    struct FGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGS>(arg0, 6, b"FGS", b"FUNGISUI", b"Hurry up and own FungiSui to become a winner!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/21_7c145d7642.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

