module 0x3e32fdefdf0fd1286e6412938d47912d812eb9508464d30a747cc494b7ab1fd2::satshi {
    struct SATSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATSHI>(arg0, 6, b"SATSHI", b"Satshi", b"With SATSHI, you're not just investing in a digital currency; You are participating in a global movement for a fairer, more accessible, and more transparent financial future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Satshi_Duck_d81eb20196.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

