module 0x1d871b42db54445525ff2f7d38f7d089ed815d657ec180677076387b0a58aebf::card {
    struct CARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARD>(arg0, 6, b"CARD", b"SUI CARD", b"There are some things money cant buy. For everything else, there's SUICARD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicard_1_9f5183057e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

