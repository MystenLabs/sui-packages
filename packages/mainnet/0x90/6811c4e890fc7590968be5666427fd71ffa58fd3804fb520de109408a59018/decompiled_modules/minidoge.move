module 0x906811c4e890fc7590968be5666427fd71ffa58fd3804fb520de109408a59018::minidoge {
    struct MINIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIDOGE>(arg0, 6, b"MiniDOGE", b"Mini DOGE", b"MiniDOGE is next BabyDOGE. Make meme great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/789_83968f2d5f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

