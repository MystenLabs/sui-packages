module 0x28e29854f65546f201232ba8dc1a4afe0579cffca8b9384764e5dd74933d964d::yourmom {
    struct YOURMOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOURMOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOURMOM>(arg0, 6, b"Yourmom", b"YourMom", x"57656c6c20697420616c6c20737461727465642061626f75742038342079656172732061676f20596f75726d6f6d2c20776f756c646e2774206c6574206d65206f6e2074686520646f6f7220616e642049206469656420696e20746865206f6365616e207768656e20594f55524d4f4d206b6e6f777320676f6f64206e2077656c6c20776520626f746820636f756c642068617665206669742e2e2e2e0a0a7468617473206e6569746865722068657265206f722074686572652062757420746861747320686f772049206d657420594f55524d4f4d0a0a526f6164204d61703a20476f2061736b20594f55524d4f4d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959094991.57")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOURMOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOURMOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

