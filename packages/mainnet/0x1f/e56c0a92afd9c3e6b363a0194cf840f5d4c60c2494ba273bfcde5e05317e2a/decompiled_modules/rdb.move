module 0x1fe56c0a92afd9c3e6b363a0194cf840f5d4c60c2494ba273bfcde5e05317e2a::rdb {
    struct RDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDB>(arg0, 9, b"RDB", b"RandomBoyz", b"Randomboyz rap group ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44a04851-85fe-439e-83ee-24000ef1dd26-1000282294.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

