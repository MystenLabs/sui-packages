module 0x60b160867842bdc7428d38580a8b3e5e37efe5b53960a5fd209389fc0dc52d0b::kakaxa {
    struct KAKAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKAXA>(arg0, 6, b"KAKAXA", b"KAKAXA SUI", x"244b414b415841202d20746865206d6f73742074727565206d656d65636f696e207769746820746865206d6f73742066756e64616d656e74616c200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pz_D3rw_T9_400x400_7980422336.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAKAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

