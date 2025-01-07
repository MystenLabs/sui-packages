module 0xe8c1d5e810f43427ec3ec55d081af5c4d6f6e4bd6cf2b29f9501d83ef2ee60a6::scm {
    struct SCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCM>(arg0, 6, b"SCM", b"SUItcase Monshtah", b"AHHH a Monshtah in a suitcase on sui, let's raaannn it aapppp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_22_at_23_25_49_0a779e6f1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

