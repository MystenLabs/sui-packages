module 0x35ffabe29a085a95aed034a8c487f67a4b5ac29d49d574379dfa6a0364c37998::pwengun {
    struct PWENGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWENGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWENGUN>(arg0, 6, b"PWENGUN", b"Pwengun", b"Meet PWENGUN, the dumbest penguin waddling on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_58_e99220a24f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWENGUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWENGUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

