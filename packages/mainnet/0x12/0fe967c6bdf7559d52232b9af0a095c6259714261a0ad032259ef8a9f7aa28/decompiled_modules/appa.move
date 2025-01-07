module 0x120fe967c6bdf7559d52232b9af0a095c6259714261a0ad032259ef8a9f7aa28::appa {
    struct APPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPA>(arg0, 6, b"APPA", b"APPA SUI", b"Get ready to ketchup with Fry Guy! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_21_27_49_35309190f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

