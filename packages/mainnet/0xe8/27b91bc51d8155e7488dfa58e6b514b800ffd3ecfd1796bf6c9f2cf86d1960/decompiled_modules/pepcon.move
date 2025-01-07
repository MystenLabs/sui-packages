module 0xe827b91bc51d8155e7488dfa58e6b514b800ffd3ecfd1796bf6c9f2cf86d1960::pepcon {
    struct PEPCON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPCON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPCON>(arg0, 6, b"PepCon", b"PepConference", b"Inspired", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004388_b6ea4b0dd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPCON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPCON>>(v1);
    }

    // decompiled from Move bytecode v6
}

