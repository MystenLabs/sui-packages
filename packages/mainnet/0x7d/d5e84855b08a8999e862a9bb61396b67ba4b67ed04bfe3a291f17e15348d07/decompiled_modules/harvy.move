module 0x7dd5e84855b08a8999e862a9bb61396b67ba4b67ed04bfe3a291f17e15348d07::harvy {
    struct HARVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARVY>(arg0, 6, b"HARVY", b"Harvey The Hedgehog", b"Harvey stayed awake for wintur, just so he can be on SUI, appreciate his effort, by helping him gather some seeds for the winter!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_3_b0893f1679.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

