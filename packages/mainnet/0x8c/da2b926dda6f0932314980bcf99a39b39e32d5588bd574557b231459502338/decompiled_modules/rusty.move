module 0x8cda2b926dda6f0932314980bcf99a39b39e32d5588bd574557b231459502338::rusty {
    struct RUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSTY>(arg0, 6, b"RUSTY", b"Rusty Spoons", b"Those rusty spoons they called to Rusty, didnt they? Soft and cold, like whispers from a distant galaxy. Rusty wasnt always a spoon collector. No, once he drifted aimlessly through the voidalone, empty-handed, and unsatisfied. The stars were too far away, the planets too barren. The cosmos, grand though it was, offered nothing but dust and silence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250428_174055_9c9d4526af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

