module 0x46d9c3264ce1516ccad7f20711c6aad3fb83c5556492fa6f10a405ad8d3d20bc::bblub {
    struct BBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLUB>(arg0, 6, b"BBlub", b"Sui Baby Blub", b"Sui $BLUB made +1000X . now it's his baby's turn!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gif_2b5b3d0b8a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

