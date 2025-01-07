module 0xa811c4721a8e5c80936ebfc70d1f65d527ff2975fae5bd5605ad1cdbb4cb65fb::book {
    struct BOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOK>(arg0, 6, b"Book", b"Book of Sui", b"The book of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_K_Gb3oa_V_400x400_ccf6cbd676.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

