module 0x3d53addb44e7969e00fccee4e6b92c7c9308c4e84abcdb7890c716e90f4ac442::meeseeks {
    struct MEESEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEESEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEESEEKS>(arg0, 6, b"MEESEEKS", b"Mr MeeSeeks", b"I am the motherfucking Mee Seeks, I've officially come to sui to conquer this shit. Are you going to fade?.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8041_56a125d56d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEESEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEESEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

