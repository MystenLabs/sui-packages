module 0x6441ec381adcc3337296db8a89946eff84faf7a71b66d32e78cd0839a825de9e::opos {
    struct OPOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPOS>(arg0, 6, b"OPOS", b"Only Possible On Sui", b"Developers from around the world are building apps on SUI for a fast, secure, scalable, and user-friendly future.  Other Chains NGMI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mk_58a9f69591.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

