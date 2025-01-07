module 0x6a745c312bdbb1e741a46a5d1d244bd1e00dd6a0a080528a072c6a0a99daa9df::pppy {
    struct PPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPPY>(arg0, 6, b"PPPY", b"PUPPY", b"PuppySui dog on the SUINETWORK ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197871_1a0e6c0a33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

