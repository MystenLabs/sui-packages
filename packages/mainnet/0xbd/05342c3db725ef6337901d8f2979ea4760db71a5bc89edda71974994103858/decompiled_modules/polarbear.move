module 0xbd05342c3db725ef6337901d8f2979ea4760db71a5bc89edda71974994103858::polarbear {
    struct POLARBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLARBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLARBEAR>(arg0, 6, b"POLARBEAR", b"Polar Bear on Sui", b"The king of the frozen north, $POLAR roams the icy tundras of Sui. Strong, resilient, and unstoppable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Polar_Bear_70508c3b60.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLARBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLARBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

