module 0x405d2f10b28d3d36d309ef7d4d7e24598bc3b5fdd18fc8cf9d25cf41cf19597a::cai {
    struct CAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CAI>(arg0, 6, b"CAI", b"CRAI by SuiAI", b"https://x.com/SevenKhan3452", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/indir_2025_01_18_T005919_347_c4dad541b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

