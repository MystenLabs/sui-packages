module 0xdbe7769813597fdddc32d0e560d66cf878576e33edcafd826379068d26956709::sharkira {
    struct SHARKIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKIRA>(arg0, 6, b"SHARKIRA", b"Sharkira On Sui", b"With every tail movement, $SHARKIRA lets out a Hips Dont Lie, swimming with the vibrant energy of La Tortura and the cunning of She Wolf. It's the most elegant predator in the ocean, conquering hearts and tokens while hitting the notes of Whenever, Wherever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_22_26_43_7a50802727.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

