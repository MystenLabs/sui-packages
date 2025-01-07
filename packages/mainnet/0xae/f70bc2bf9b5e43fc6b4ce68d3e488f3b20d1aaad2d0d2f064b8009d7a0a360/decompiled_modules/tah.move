module 0xaef70bc2bf9b5e43fc6b4ce68d3e488f3b20d1aaad2d0d2f064b8009d7a0a360::tah {
    struct TAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAH>(arg0, 6, b"TAH", b"SUITAH", b"SUItah brings a fresh, laid-back attitude to the meme coin scene on the SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Qrx_SA_Ea_400x400_68dc59b818.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

