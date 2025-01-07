module 0x5e0641bd1163ec77abf9e2e5a62143a4b405d58fdd47833a19272cec59495fd0::tamago {
    struct TAMAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMAGO>(arg0, 6, b"TAMAGO", b"Tamago The Chick", b"Salary chick trying to navigate through the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tamago_0fa2a37e8b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAMAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

