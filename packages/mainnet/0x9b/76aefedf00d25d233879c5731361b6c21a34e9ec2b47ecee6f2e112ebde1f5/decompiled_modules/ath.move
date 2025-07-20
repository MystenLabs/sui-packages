module 0x9b76aefedf00d25d233879c5731361b6c21a34e9ec2b47ecee6f2e112ebde1f5::ath {
    struct ATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ATH>(arg0, 6, b"ATH", b"A", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $ATH + A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ath-0csan4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

