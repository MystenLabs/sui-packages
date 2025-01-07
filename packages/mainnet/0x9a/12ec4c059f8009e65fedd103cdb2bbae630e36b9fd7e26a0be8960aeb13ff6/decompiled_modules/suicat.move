module 0x9a12ec4c059f8009e65fedd103cdb2bbae630e36b9fd7e26a0be8960aeb13ff6::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"Suicat", b"SuiCAT", b"Meet the newest feline sensation on the Sui blockchain! SuiCAT is not just another meme coin; its a purrfectly unique, cat-themed gem that's ready to take over the #Sui ecosystem. Don't miss your chance to join the cat crew and be a part of the SuiCAT movement.  Get in early, grab your SuiCAT tokens, and lets make some meow-velous gains together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicat_b7f768763a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

