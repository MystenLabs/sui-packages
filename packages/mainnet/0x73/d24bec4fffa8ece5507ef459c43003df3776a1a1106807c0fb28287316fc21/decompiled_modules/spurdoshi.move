module 0x73d24bec4fffa8ece5507ef459c43003df3776a1a1106807c0fb28287316fc21::spurdoshi {
    struct SPURDOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPURDOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPURDOSHI>(arg0, 6, b"SPURDOSHI", b"SPURDOSHI SUI", x"6461207265656c2073707572646f736869206973206461206672656e73207765206d6164652061726f6e672064612077616520782d2d2d2d4444444444440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_18_23_31_92cd49a053.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPURDOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPURDOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

