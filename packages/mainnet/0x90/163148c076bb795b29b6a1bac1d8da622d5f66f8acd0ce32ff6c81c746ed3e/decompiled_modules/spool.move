module 0x90163148c076bb795b29b6a1bac1d8da622d5f66f8acd0ce32ff6c81c746ed3e::spool {
    struct SPOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOL>(arg0, 6, b"Spool", b"Suipool", b"The ultimate memetoken, combining the best of cinema and the best of memes in the best SUI channel.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000091829_bde901c71b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

