module 0x66588e177ead358438c5bc8781244baf172669c1536ffef95d064f60e10c98df::fwoppy {
    struct FWOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOPPY>(arg0, 6, b"FWOPPY", b"FWOPPY the FROG", x"6d6967687420626520736f6d657468696e672066776f7070790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fwoppy_logo_178360b17a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

