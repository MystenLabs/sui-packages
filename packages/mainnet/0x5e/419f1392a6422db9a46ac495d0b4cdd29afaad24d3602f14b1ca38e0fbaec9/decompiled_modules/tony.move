module 0x5e419f1392a6422db9a46ac495d0b4cdd29afaad24d3602f14b1ca38e0fbaec9::tony {
    struct TONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONY>(arg0, 6, b"TONY", b"What's up Homies I'm  Tony", b"Check out this new neon product, with tracked", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tony_3959edb88e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

