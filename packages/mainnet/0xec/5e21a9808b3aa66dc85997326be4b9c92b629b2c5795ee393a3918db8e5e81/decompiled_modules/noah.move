module 0xec5e21a9808b3aa66dc85997326be4b9c92b629b2c5795ee393a3918db8e5e81::noah {
    struct NOAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOAH>(arg0, 6, b"NOAH", b"Nut Noah", b"If you like Chillaxing, then Noah is your guy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000091412_1941ae140d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

