module 0xe4df33d95de4d52abf4858c75e36512fc4e630ea9989558051cc34ea911926b5::ming {
    struct MING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MING>(arg0, 1, b"Ming", b"DAOmingsi", b"The Asia's Phenomenal Heart Rub <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/ce112590-d986-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MING>>(v1);
        0x2::coin::mint_and_transfer<MING>(&mut v2, 11000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MING>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

