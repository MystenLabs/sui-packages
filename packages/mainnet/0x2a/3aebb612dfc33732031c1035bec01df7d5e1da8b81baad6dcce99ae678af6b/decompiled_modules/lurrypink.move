module 0x2a3aebb612dfc33732031c1035bec01df7d5e1da8b81baad6dcce99ae678af6b::lurrypink {
    struct LURRYPINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LURRYPINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LURRYPINK>(arg0, 6, b"LURRYPINK", b"BlackRock", b" $Blackrock on SUI and crypto degen alter-ego of Larry Fink!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GREEK_b084b7e0a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LURRYPINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LURRYPINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

