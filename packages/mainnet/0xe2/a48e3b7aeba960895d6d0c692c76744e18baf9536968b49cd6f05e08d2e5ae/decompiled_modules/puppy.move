module 0xe2a48e3b7aeba960895d6d0c692c76744e18baf9536968b49cd6f05e08d2e5ae::puppy {
    struct PUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPY>(arg0, 6, b"PUPPY", b"PUPPYSUI", b"the dog of sui co-founder, evan cheng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197080_c3df6a79ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

