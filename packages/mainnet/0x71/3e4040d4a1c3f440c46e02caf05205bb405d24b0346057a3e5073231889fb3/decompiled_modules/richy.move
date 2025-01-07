module 0x713e4040d4a1c3f440c46e02caf05205bb405d24b0346057a3e5073231889fb3::richy {
    struct RICHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHY>(arg0, 6, b"RICHY", b"Richy on Sui", b"u must HODL to be RICH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fufu_001_470dc52900.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

