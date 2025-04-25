module 0xb096b51fce312971f1d3e65f5d8073bc3431b8a9a8ccffb8a8b4f6337d41a82e::tent {
    struct TENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENT>(arg0, 6, b"TENT", b"Tentcoin", b"The tent market is rising. A comfy fent tent is the house of the 21st century. 1 tent = 1 tentcoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1236_b37b90e1f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

