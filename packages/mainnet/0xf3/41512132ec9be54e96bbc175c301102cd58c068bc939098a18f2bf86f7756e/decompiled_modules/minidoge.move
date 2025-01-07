module 0xf341512132ec9be54e96bbc175c301102cd58c068bc939098a18f2bf86f7756e::minidoge {
    struct MINIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIDOGE>(arg0, 6, b"Minidoge", b"minidoge", b"Minidoge is a meme brought by Elon Musk on his X:https://x.com/elonmusk/status/1865304483070169440", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ge_Lkimk_Xc_A_Acyd7_53e776ef5e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

