module 0x5fbcc29e4d7d2f9fa9b6e25b5d536c79a1bc780517941efdfbdba4c948e71973::pert {
    struct PERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERT>(arg0, 6, b"PERT", b"Perry the Teacher", b"The wise and quirky Perry of the Sui ecosystem! Known for both curiosity and cleverness, $PERT is here to teach and guide newcomers through the currents of Sui, making the journey smooth and enlightening. Dive into the crypto world with $PERT as your knowledgeable guide!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PLATY_4d1e3703bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

