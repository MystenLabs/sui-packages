module 0xaf353bfa466251ae59faafca41f9bada5ac485cd4b1e328dd4d37311d0f3bcf4::babyag {
    struct BABYAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAG>(arg0, 6, b"BABYAG", b"Baby Axol Gate", b"Baby Axol is a fun and adorable memecoin inspired by the quirky amphibian thats known for its ability to regenerate and bring joy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/babyaxo_a4e77d824b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

