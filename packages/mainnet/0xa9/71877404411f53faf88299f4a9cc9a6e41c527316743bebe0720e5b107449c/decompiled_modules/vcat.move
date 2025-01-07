module 0xa971877404411f53faf88299f4a9cc9a6e41c527316743bebe0720e5b107449c::vcat {
    struct VCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCAT>(arg0, 6, b"VCAT", b"CAT", b"V God doesn't have a dog but a cat. We are just a boss cat. Let's build together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012748_014ffafaed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

