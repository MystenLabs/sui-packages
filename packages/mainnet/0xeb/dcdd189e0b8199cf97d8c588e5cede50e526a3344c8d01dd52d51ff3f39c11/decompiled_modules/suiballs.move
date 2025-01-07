module 0xebdcdd189e0b8199cf97d8c588e5cede50e526a3344c8d01dd52d51ff3f39c11::suiballs {
    struct SUIBALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBALLS>(arg0, 6, b"SUIBALLS", b"Balls", b"Do you have Balls? Sui just got a pair.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIBALLS_78a1404558.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

