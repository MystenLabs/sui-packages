module 0x3d26065a5fd8eb72ac7c0d6aa0380b05c26f0e64afb9268c3e793f9242de5df6::popfish {
    struct POPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPFISH>(arg0, 6, b"POPFISH", b"Pop Fish sui", x"506f7046697368206f6e2053554920706f7020706f7020706f70205447203a2068747470733a2f2f742e6d652f706f70666973687375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pop_Fish_s_18282a6413.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

