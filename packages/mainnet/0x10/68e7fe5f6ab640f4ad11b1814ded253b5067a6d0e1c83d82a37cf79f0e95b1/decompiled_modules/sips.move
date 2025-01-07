module 0x1068e7fe5f6ab640f4ad11b1814ded253b5067a6d0e1c83d82a37cf79f0e95b1::sips {
    struct SIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIPS>(arg0, 6, b"SIPS", b"Sips", x"456d706f776572696e67206469676974616c20746f6765746865726e6573732c206f6e652073697020617420612074696d652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sips_3b2f6dc648.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

