module 0xc86e33757c4e20d116fa1b48701d4fa75a2de9fd0f6899523b644e4192b4ae32::srump {
    struct SRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRUMP>(arg0, 6, b"SRUMP", b"Trump Is Presuident", b"Our newly elected PreSUIdent of the Water chain is now on his way to becoming the next President of the United States", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_token_0fe7c5fdba.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

