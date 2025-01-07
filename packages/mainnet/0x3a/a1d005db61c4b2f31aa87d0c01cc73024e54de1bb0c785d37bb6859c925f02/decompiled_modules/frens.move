module 0x3aa1d005db61c4b2f31aa87d0c01cc73024e54de1bb0c785d37bb6859c925f02::frens {
    struct FRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENS>(arg0, 6, b"FRENS", b"SUIFRENS", b"First there were Capys. SuiSeason is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifrens_09a2ddcac5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

