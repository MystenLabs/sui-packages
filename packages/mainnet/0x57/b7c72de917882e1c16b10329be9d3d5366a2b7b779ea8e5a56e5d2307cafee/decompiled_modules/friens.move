module 0x57b7c72de917882e1c16b10329be9d3d5366a2b7b779ea8e5a56e5d2307cafee::friens {
    struct FRIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIENS>(arg0, 6, b"FRIENS", b"SUI_FRENS", b"SuiFrens are beloved imaginative, inventive creatures traversing the internet, seeking fellow pioneers to build new connections and friendships.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RW_4_Xp_C25_400x400_2f312e3997.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

