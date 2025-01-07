module 0xb1a78046d45889f7f95805702ea9450882d5ced118111e89de3497179df00edd::blood {
    struct BLOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOD>(arg0, 6, b"BLOOD", b"Bloodboy", b"We're all just sacks of skin filled with $BLOOD  Matt Furie Character ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_4_36358eff04.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

