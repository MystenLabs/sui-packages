module 0x134e968421ec73095cb9957128b93212ff8da81106c2e8e88600c9799b4e5495::bbbmonk {
    struct BBBMONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBBMONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBBMONK>(arg0, 6, b"bbbMONK", b"Business Monkey", b"Can't stop, won't stop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_06_20_15_58_removebg_preview_547c76a9d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBBMONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBBMONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

