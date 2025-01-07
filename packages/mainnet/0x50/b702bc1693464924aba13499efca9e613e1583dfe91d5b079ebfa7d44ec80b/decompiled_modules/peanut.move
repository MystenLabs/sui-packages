module 0x50b702bc1693464924aba13499efca9e613e1583dfe91d5b079ebfa7d44ec80b::peanut {
    struct PEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT>(arg0, 6, b"PEANUT", b"Sui Sheriff Peanut", b"Im Sui SheriffPeanut, the squirrel in charge of keeping this forest safe and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_sheriffpeanut_icon_dex_192x192_7b8a6a5759.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEANUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEANUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

