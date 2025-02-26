module 0x6400ec35be3616828a5ecbdd2622fbc698f9af900768f731e9f8621e283a0551::complete {
    struct COMPLETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMPLETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMPLETE>(arg0, 9, b"complete", b"complete", b"complete", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"complete")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COMPLETE>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMPLETE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COMPLETE>>(v2);
    }

    // decompiled from Move bytecode v6
}

