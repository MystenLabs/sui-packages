module 0xf8137e950a74022da3201c06b472cb90eaf32724eaf5c2b8cc579439873faa3c::pie {
    struct PIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIE>(arg0, 6, b"PIE", b"DEEP PIE", b"DEEP FUCKING PIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DEEPPIE_116f628f1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

