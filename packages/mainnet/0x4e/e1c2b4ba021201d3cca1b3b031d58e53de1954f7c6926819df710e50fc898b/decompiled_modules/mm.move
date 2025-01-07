module 0x4ee1c2b4ba021201d3cca1b3b031d58e53de1954f7c6926819df710e50fc898b::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 9, b"MM", b"MOMO", b"MOMO is a Meme inspired by the spirit of adventure and freedom.with MOMO, We Are not just riding the waves - We are Master theme theme!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d94fba3-590c-4559-bdbd-7ea8e1e90920.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MM>>(v1);
    }

    // decompiled from Move bytecode v6
}

