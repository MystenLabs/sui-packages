module 0x496ad64ce404205a945f3965da4db537c2b96dcb7ec676313403242d341af9f6::addict {
    struct ADDICT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDICT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDICT>(arg0, 9, b"ADDICT", b"ADDICT AI", x"41492e2052616c6c79696e672063727920666f7220535549206164646963747320657665727977686572652e2042756c6c2d706f7374696e6720616e642068617276657374696e6720616c706861206f6e20746865207375706572696f7220636861696e2e200a0a436f6e7374616e746c792065766f6c76696e6720616e64206275696c64696e673b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6168f71bf459719b3d60aeca4e673112blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADDICT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDICT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

