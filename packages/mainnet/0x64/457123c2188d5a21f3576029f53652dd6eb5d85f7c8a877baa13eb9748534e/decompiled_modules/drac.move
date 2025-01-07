module 0x64457123c2188d5a21f3576029f53652dd6eb5d85f7c8a877baa13eb9748534e::drac {
    struct DRAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAC>(arg0, 6, b"Drac", b"Dracelon", b"meme coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_13_62ac36c36f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

