module 0xaaba86358f5276b357421cebebd5143c4fce4b4550bf295f67bc392b2bc78569::nst {
    struct NST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NST>(arg0, 6, b"NST", b"NST ON SUI", b"Welcome to Ninja Squad, we are the true OG degen futures and memecoin trading community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_20_at_3_34_44a_pm_e5a8c63f68.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NST>>(v1);
    }

    // decompiled from Move bytecode v6
}

