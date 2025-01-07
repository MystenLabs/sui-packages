module 0x9d419c6c87390695baec5fe50348b0e3c6d683c44f522df8772c1426f0140c92::zombie {
    struct ZOMBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIE>(arg0, 6, b"Zombie", b"Zombie Cat", b"This cat got nine lives and its burned through them all, clawing its way back from every rug pull, dip, and bear market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_14_T202703_092_7f8e8055f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOMBIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

