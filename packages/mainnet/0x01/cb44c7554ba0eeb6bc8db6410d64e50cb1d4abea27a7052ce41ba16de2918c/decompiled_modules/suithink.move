module 0x1cb44c7554ba0eeb6bc8db6410d64e50cb1d4abea27a7052ce41ba16de2918c::suithink {
    struct SUITHINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITHINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITHINK>(arg0, 6, b"SuiThink", b"Sui Think", b"\"Think Less. Hold More. $Suithink.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiezn6nqjdlgwysxowy6tzvqob7k5uktljnyqj6fgfzimsyzi6emtm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITHINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITHINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

