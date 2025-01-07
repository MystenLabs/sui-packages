module 0xa2acca89eb2082440bcb4dd88bd859e57d002f9b442594dd43cdef267f8cae85::bac {
    struct BAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAC>(arg0, 6, b"BAC", b"BASED AMERICAN CAT", b"Based American cat is the cutest for sol chain cat coin and will develop into the best cat meme coin. For cat lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_06_152612_a3ae0a368c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

