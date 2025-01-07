module 0x117b949586574225454c05a7c4751496b880b0b3029cdbe4679b477aa1776b4::akira {
    struct AKIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKIRA>(arg0, 6, b"AKIRA", b"Akira Cat", b"Meow meow meow meow meow meow meow meow meow meow meow meow. Akira is meowing on Sui. A cat with an extraordinary dream; to swim in water on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_20abf058d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

