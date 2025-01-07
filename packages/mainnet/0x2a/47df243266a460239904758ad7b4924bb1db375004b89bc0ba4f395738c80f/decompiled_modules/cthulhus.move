module 0x2a47df243266a460239904758ad7b4924bb1db375004b89bc0ba4f395738c80f::cthulhus {
    struct CTHULHUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTHULHUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTHULHUS>(arg0, 6, b"CTHULHUS", b"CTHULHU", x"5468652064656570206177616974732e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_194856611_99b92292d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTHULHUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTHULHUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

