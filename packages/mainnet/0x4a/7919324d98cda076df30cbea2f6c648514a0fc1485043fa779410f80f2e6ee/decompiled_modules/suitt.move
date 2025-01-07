module 0x4a7919324d98cda076df30cbea2f6c648514a0fc1485043fa779410f80f2e6ee::suitt {
    struct SUITT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITT>(arg0, 6, b"SUITT", b"SUITTER", x"546865206f6e6c79207265616c20672075736572205375690a75736572207375693a20537569747465720a6f7468657220757365723a2058", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/suiter_a699947945.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITT>>(v1);
    }

    // decompiled from Move bytecode v6
}

