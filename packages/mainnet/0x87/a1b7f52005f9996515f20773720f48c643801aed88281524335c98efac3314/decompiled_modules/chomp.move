module 0x87a1b7f52005f9996515f20773720f48c643801aed88281524335c98efac3314::chomp {
    struct CHOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMP>(arg0, 6, b"CHOMP", b"Chomp", b"Hey it's CHOMP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chomp_df3b4516a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

