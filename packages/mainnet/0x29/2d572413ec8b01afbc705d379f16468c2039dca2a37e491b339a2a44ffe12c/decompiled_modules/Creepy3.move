module 0x292d572413ec8b01afbc705d379f16468c2039dca2a37e491b339a2a44ffe12c::Creepy3 {
    struct CREEPY3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREEPY3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREEPY3>(arg0, 9, b"CREEPY4", b"Creepy3", b"creeppy so creepy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1930633311883317249/ywMq66aa_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREEPY3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREEPY3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

