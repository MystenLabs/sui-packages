module 0xa06bda65ae5e6833dc3833417bc9e8ff6c172215052619eb9a02a6c5e03df358::moe {
    struct MOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOE>(arg0, 9, b"MOE", b"MOEW", b"meow meow meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e65bb6b8-d5a5-43b8-af07-ac232679a8ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

