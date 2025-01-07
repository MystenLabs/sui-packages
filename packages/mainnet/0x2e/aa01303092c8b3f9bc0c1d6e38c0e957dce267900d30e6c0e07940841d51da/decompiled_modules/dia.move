module 0x2eaa01303092c8b3f9bc0c1d6e38c0e957dce267900d30e6c0e07940841d51da::dia {
    struct DIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIA>(arg0, 6, b"DIA", b"DIABLO", b"Elon play Diablo - an action role-playing dungeon crawler video game series developed by Blizzard North and continued by Blizzard Entertainment after the North studio shut down in 2005.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diablo_III_cover_d4d02d7449.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

