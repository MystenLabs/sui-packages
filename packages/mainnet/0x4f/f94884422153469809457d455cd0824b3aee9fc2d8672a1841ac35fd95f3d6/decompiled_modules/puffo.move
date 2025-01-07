module 0x4ff94884422153469809457d455cd0824b3aee9fc2d8672a1841ac35fd95f3d6::puffo {
    struct PUFFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFO>(arg0, 6, b"PUFFO", b"puffo", x"666c75666669657374206167656e740a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1ap_HYOC_6_400x400_42c261ebd5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

