module 0xd950f62c82351842ed90a51d07a5c731891401e05a2074b4cf5faf108a5795d9::aeeg {
    struct AEEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEEG>(arg0, 6, b"AEEG", b"zafe", b"azfzeg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixel_art_star_vector_21403738_0b50842fd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

