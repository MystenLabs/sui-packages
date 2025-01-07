module 0x6d47899fcf72358ec63391cee7d267ed353f899014d353c2da86f855573a2601::terminator {
    struct TERMINATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINATOR>(arg0, 6, b"TERMINATOR", b"ARNOLD SUIWARZENEGGER", b"Hasta la vista, baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Terminator_2_judgement_day_59fd540f46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERMINATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

