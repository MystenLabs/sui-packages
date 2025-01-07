module 0x840a7afafa47ce1cf1f6bba724079c97732b70974e590a94d5a116159946c1d5::tet {
    struct TET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TET>(arg0, 6, b"TET", b"test", b"test coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cuplikan_layar_2024_09_19_155205_945fdea710.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TET>>(v1);
    }

    // decompiled from Move bytecode v6
}

