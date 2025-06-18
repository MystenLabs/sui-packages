module 0x87068aa89278739bc87652303b21783045773b38499df0d9f60c359c3a9e8abe::cf {
    struct CF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CF>(arg0, 6, b"CF", b"CatFish", b"Maybe cat? Maybe fish?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8738_b9ce4c146f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CF>>(v1);
    }

    // decompiled from Move bytecode v6
}

