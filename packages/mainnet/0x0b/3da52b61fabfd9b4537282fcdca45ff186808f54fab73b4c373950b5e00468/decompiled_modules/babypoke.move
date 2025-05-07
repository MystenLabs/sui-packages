module 0xb3da52b61fabfd9b4537282fcdca45ff186808f54fab73b4c373950b5e00468::babypoke {
    struct BABYPOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPOKE>(arg0, 6, b"BABYPOKE", b"BabyPokeSui", b"BABYPOKE is landing on Sui to become the number one mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250508_033015_674_068bf43930.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

