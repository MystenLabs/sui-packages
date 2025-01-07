module 0x11d9408f17330d9716911d0c17895a0d2a35d89c14a5d96cf8fdfec3177a9538::spurr {
    struct SPURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPURR>(arg0, 6, b"SPURR", b"SUIPURR", b"Meet SUIPURR, the first superhero cat on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/SUIPURR_ac0b0b0802.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPURR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPURR>>(v1);
    }

    // decompiled from Move bytecode v6
}

