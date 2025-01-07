module 0x8569d25ab4a03b7a0b71c71ba46692940ede91e6fb193638be8807d0f9ed2999::dogita {
    struct DOGITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGITA>(arg0, 6, b"DOGITA", b"Dogita", x"446f67697461206973207468652066697273742d657665722075706772616465206f662074686520766972616c20444f4745206d656d65206f6e205355492e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ovmon_9139c9df15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

