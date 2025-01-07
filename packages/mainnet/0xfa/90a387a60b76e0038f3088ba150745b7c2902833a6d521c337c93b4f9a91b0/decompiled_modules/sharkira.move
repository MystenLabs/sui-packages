module 0xfa90a387a60b76e0038f3088ba150745b7c2902833a6d521c337c93b4f9a91b0::sharkira {
    struct SHARKIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKIRA>(arg0, 6, b"SHARKIRA", b"Sharkira", b"With every tail movement, $SHARKIRA lets out a Hips Dont Lie, swimming with the vibrant energy of La Tortura and the cunning of She Wolf. It's the most elegant predator in the ocean, conquering hearts and tokens while hitting the notes of Whenever, Wherever. With sharp claws and a superstar attitude, it will sing Waka Waka as it reaches the heights of SUI Network. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_22_26_43_df5b70b11e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

