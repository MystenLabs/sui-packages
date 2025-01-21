module 0x7571b9fc9bd4ceab009530ae2e104a2462fcf7bb7f59809031e36bb60680d70a::pyrate {
    struct PYRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYRATE>(arg0, 6, b"PYRATE", b"Pyrate Gang", b"as a project our main objective is to create path of least resistance for everyone in the crypto space and overtake the corrupt centralized banking system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pyrate_logo_51464e6ff9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYRATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PYRATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

