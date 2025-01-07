module 0x5724210be0da80e4d25b3534de46cc98b278ee65e46536d93059a06ded90c913::usdsui {
    struct USDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDSUI>(arg0, 6, b"USDSUI", b"USDSUI (USDC on SUI)", b"It's late I'm gonna get some rest. If I wake up and this has bonded I'll pay for dex. Someone make a tg.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_99_d5297c248f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

