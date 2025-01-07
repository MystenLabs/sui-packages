module 0xb5bca35886c117a44742898c6fe8d6332d2f8cf194b6b1e02dcb74cf48d967e9::suier {
    struct SUIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIER>(arg0, 6, b"SUIER", b"SUIer", b"Serious laborers can be funny, too.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suier2_917f4dc6be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIER>>(v1);
    }

    // decompiled from Move bytecode v6
}

