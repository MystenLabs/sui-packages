module 0x8b3e3589eafdf0da147f402302669c143fdef9a1db8139bf08103941020ab322::babyping {
    struct BABYPING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPING>(arg0, 6, b"BABYPING", b"Baby seal Ping", b"Ping cutest baby seal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_9b566bb142.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPING>>(v1);
    }

    // decompiled from Move bytecode v6
}

