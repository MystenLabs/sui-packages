module 0xbfd591c553a3013843126c7b838db6c2d9397dc16f221b0da98aa478f5f89b9::pater {
    struct PATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATER>(arg0, 6, b"PATER", b"Who is Ciprian?", b"The AntiChrist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pater_c327dd311f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

