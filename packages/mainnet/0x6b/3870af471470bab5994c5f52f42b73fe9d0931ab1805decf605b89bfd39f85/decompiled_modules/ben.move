module 0x6b3870af471470bab5994c5f52f42b73fe9d0931ab1805decf605b89bfd39f85::ben {
    struct BEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEN>(arg0, 6, b"Ben", b"ben", b"asdfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_07_25_at_23_28_29_19aaea928f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

