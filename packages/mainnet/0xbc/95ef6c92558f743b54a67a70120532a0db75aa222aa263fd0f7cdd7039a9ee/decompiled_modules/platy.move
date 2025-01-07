module 0xbc95ef6c92558f743b54a67a70120532a0db75aa222aa263fd0f7cdd7039a9ee::platy {
    struct PLATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLATY>(arg0, 6, b"PLATY", b"PLATY ON SUI!!", b"$PLATY is the quirky, fun-loving token inspired by the unique platypus, bringing a splash of joy to the Sui network. Dive into the world of $PLATY and join the coolest community on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PLATY_001e1bcbd3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

