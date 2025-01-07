module 0xd0a2be303135c7d87e9103ccea5436ad89304992e0baed257c201e483fcd12bc::spamer {
    struct SPAMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAMER>(arg0, 6, b"SPAMER", b"SPAMER | SUI", x"5350414d4552207c205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3058_311bc73555.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

