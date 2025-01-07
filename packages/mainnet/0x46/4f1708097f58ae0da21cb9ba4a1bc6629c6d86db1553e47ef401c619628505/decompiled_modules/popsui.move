module 0x464f1708097f58ae0da21cb9ba4a1bc6629c6d86db1553e47ef401c619628505::popsui {
    struct POPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUI>(arg0, 6, b"POPSUI", b"POP SUI", b"We're bringing the Pop to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_08_T152918_289_d8d1ad6ed1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

