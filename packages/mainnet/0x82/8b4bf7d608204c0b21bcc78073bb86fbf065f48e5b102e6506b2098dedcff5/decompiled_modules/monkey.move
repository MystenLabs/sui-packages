module 0x828b4bf7d608204c0b21bcc78073bb86fbf065f48e5b102e6506b2098dedcff5::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MONKEY>, arg1: 0x2::coin::Coin<MONKEY>) {
        0x2::coin::burn<MONKEY>(arg0, arg1);
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONK", b"Monkey", b"The primate-guided manifesto for the digital age. Slow down. Appreciate the quiet. Eat the banana. Forget the prompt, return to monke.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fyk6RUb.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MONKEY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MONKEY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

