module 0x6cf0bd1ab1e59574269df376764df9d816568d8ccc7e38d78ca3867e8501e91f::moony {
    struct MOONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONY>(arg0, 6, b"MOONY", b"MOONY SUI", b"Meet Moony, our adorable donut-loving cat whos taking the blockchain by storm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_15_01_08_2db1f6418b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

