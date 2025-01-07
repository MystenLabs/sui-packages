module 0xda8c6ef008fd5753f4e4397e73cf4802f228838b50328011cf24ed54980c5bfe::peach {
    struct PEACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACH>(arg0, 6, b"PEACH", b"Peaches on SUI", b"Ripe & Bountiful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wb_Ju_Ju9x_400x400_77ba7927c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACH>>(v1);
    }

    // decompiled from Move bytecode v6
}

