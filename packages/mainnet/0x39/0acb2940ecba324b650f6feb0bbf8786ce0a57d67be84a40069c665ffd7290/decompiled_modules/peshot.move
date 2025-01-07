module 0x390acb2940ecba324b650f6feb0bbf8786ce0a57d67be84a40069c665ffd7290::peshot {
    struct PESHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESHOT>(arg0, 6, b"PESHOT", b"Pepe Gonna Shot Youu", b"You sell you die, Jeet !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/th_207ae177dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESHOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESHOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

