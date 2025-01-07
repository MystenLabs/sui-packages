module 0xdcb96548bf3cea39614ea5f6e75044b2d5674218f3ec0dde38766387124b6190::minisui {
    struct MINISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINISUI>(arg0, 6, b"MiniSui", b"MiniSui!!", b"Hello Sui People! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mini_SUI_142e1dff11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

