module 0x4ee18bd1f36c8f16174274dd51787690ba005a1b9b564e351f138f8b74c5628c::ocat {
    struct OCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCAT>(arg0, 6, b"OCAT", b"Ocean Cat", x"54686520657863656c6c656e74207377696d6d65722063617420696e205375692e20426c756227732061646f70746564206361742066726f6d20746865206c616e642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/458295905_881677460017207_3824126518240296207_n_42ac7d4f21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

