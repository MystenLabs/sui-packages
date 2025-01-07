module 0x8cf776007ad6326f7d97fecc47844103ddc1e56108542693dbccc3aac18341bf::bdt {
    struct BDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDT>(arg0, 6, b"BDT", b"Banana", b"Banana with Duct Tape\", the most unusual artwork of the year, was auctioned for more than 201 million baht ... The artwork \"Comedian\", also known as \"Banana with Duct Tape\", the most unusual artwork of the year, was auctioned for a high price of 6.2 million US dollars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1141_abf88b5e99.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

