module 0xf30ad12359dbd46a3f4fb2a4e386f50027120a380d64f3cea9aa1f4fb1818a75::pumpkit {
    struct PUMPKIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPKIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPKIT>(arg0, 6, b"PUMPKIT", b"Pumpkitty", b"I'm the purrfect Halloween treat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pumpkincatlogo_0132a4b319.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPKIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPKIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

