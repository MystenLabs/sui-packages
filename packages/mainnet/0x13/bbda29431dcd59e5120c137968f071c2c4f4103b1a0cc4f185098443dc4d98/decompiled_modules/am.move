module 0x13bbda29431dcd59e5120c137968f071c2c4f4103b1a0cc4f185098443dc4d98::am {
    struct AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AM>(arg0, 6, b"AM", b"Adeniyius maximus", b"Adeniyius maximus the overlord of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2025_01_01_T201326_527_337d9701c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AM>>(v1);
    }

    // decompiled from Move bytecode v6
}

