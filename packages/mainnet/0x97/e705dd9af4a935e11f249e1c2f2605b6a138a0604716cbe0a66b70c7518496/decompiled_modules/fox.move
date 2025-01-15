module 0x97e705dd9af4a935e11f249e1c2f2605b6a138a0604716cbe0a66b70c7518496::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"SuiFOX", b"Welcome to the SuiFOX Community!  Thank you for joining us on this exciting journey! SuiFOX is more than just a meme tokenit's a vibrant ecosystem powered by the Sui Movepump and driven by an amazing community. Together, we'll create fun, value, and endless possibilities. Stay tuned, get involved, and lets make SuiFOX the next big thing in the crypto world! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000199402_89e8bd413f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

