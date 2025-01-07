module 0x9e06747c53c447b1c12b635cd691c52c7c4ee6dfdd4d508f113347d29e336f52::mctrump {
    struct MCTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCTRUMP>(arg0, 6, b"MCTRUMP", b"MCTRUMP SUI", b"$MCTRUMP IS MCDONALD TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4114_d61c8ec938.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

