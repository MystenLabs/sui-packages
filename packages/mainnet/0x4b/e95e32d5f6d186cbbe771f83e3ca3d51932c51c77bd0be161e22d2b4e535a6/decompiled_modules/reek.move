module 0x4be95e32d5f6d186cbbe771f83e3ca3d51932c51c77bd0be161e22d2b4e535a6::reek {
    struct REEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: REEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REEK>(arg0, 6, b"Reek", b"Unsung Hero", b"Make this unsung hero your HERO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/reek_theon_f113ae263b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

