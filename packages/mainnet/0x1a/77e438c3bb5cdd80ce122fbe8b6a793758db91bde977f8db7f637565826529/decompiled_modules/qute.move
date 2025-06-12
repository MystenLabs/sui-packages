module 0x1a77e438c3bb5cdd80ce122fbe8b6a793758db91bde977f8db7f637565826529::qute {
    struct QUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUTE>(arg0, 6, b"Qute", b"QUTE", b"Just too Qute to not make it it to millions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cuteeet_0a87bd3514.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

