module 0x6611f4924c436e98658977b36d1ad6ccd4f3bf969b32153ceb3cd4309522619b::misui {
    struct MISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISUI>(arg0, 6, b"MISUI", b"MINI ON SUI", b"Miniest meme in the memecoin sui minisystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/minionsui_b55c17f48a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

