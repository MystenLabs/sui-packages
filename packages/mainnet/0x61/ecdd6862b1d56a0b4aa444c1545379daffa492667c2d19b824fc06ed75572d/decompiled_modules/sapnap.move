module 0x61ecdd6862b1d56a0b4aa444c1545379daffa492667c2d19b824fc06ed75572d::sapnap {
    struct SAPNAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPNAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPNAP>(arg0, 6, b"SAPNAP", b"Sapnap", b"After much consideration, we announce to launch our official coin $SAPNAP we are sure sapnap will be the most famous and biggest coin in this network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058009_d5c40ba4ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPNAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPNAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

