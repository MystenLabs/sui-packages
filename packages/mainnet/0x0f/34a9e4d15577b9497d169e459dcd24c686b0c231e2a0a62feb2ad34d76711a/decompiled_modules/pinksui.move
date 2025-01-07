module 0xf34a9e4d15577b9497d169e459dcd24c686b0c231e2a0a62feb2ad34d76711a::pinksui {
    struct PINKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKSUI>(arg0, 6, b"PINKSUI", b"PINK", b"PINKSUI IS PINK ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/645b805021f132cd428ccc11bf6d43c9_2076639048_7e5ad8337c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

