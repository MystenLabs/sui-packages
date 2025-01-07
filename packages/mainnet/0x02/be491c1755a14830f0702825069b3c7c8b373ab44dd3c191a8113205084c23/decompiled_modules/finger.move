module 0x2be491c1755a14830f0702825069b3c7c8b373ab44dd3c191a8113205084c23::finger {
    struct FINGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINGER>(arg0, 6, b"Finger", b"Fingerprint", b"Leave your mark on the SUI ecosystem with Fingerprint. One touch at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmNjshAEe9bKQ3ixcDqgZ7XrDxXbGEANsAzVJUMKhroYQt")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FINGER>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FINGER>(18294242644664160044, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

