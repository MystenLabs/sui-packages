module 0x2cb4dc16e67ffbbb10a7876ac82c1c11c772576aff2fff96acfa2ae1e48e8b75::woolly {
    struct WOOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOLLY>(arg0, 6, b"WOOLLY", b"WOOLLY MONKEY", x"4a757374206120776f6f6c6c79206d6f6e6b65792e200a4f6e6c792061626f75742031303030206f66207468656d206c65667420696e2074686520776f726c642e0a536176652024776f6f6c6c79", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/woo_min2_e1e67c3acd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

