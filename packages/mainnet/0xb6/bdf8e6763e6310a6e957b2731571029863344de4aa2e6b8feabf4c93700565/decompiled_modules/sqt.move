module 0xb6bdf8e6763e6310a6e957b2731571029863344de4aa2e6b8feabf4c93700565::sqt {
    struct SQT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQT>(arg0, 6, b"SQT", b"SUIquirtle", x"5468652062657374207374617274657220696e20506f6b656d6f6e2052656420616e6420477265656e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_removebg_preview_1_4e8a4a8410.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQT>>(v1);
    }

    // decompiled from Move bytecode v6
}

