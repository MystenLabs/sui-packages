module 0x65b88156e9805a90dec86bc8670cdfb6e7aa3792fec97cede01f3ac94668d46d::nextfundai {
    struct NEXTFUNDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXTFUNDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXTFUNDAI>(arg0, 6, b"Nextfundai", b"NEXTFUNDAI", b"NEXTFUNDAI powered by FBI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qaaa_71059cd99f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXTFUNDAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEXTFUNDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

