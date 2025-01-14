module 0x5d465ec4c855a6c5d1c866ac2186b82c7b476554d25e82a55a221d68060b6c47::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"Fluffy", b"Fluffy ", x"496e74726f647563696e6720464c55464659202d204d617474204675726965e280997320707269646520616e64206a6f792066726f6d20686973206f726967696e616c20636f6d696320736572696573200a0a73616d65207465616d207769746820746865206574682024666c756666790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736880787329.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

