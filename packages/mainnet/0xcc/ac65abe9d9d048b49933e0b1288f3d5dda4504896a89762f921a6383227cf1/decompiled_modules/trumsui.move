module 0xccac65abe9d9d048b49933e0b1288f3d5dda4504896a89762f921a6383227cf1::trumsui {
    struct TRUMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMSUI>(arg0, 6, b"TRUMsui", b"TRUM", b"https://t.me/+K5X2BZ4bXnc3Y2I1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_27_at_10_40_12a_pm_9e606024e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

