module 0x70cfab2eef996bbcb38807e2f766d9e0c75782234985ef54d192605f832e9ab1::oneusd {
    struct ONEUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEUSD>(arg0, 6, b"Oneusd", b"1$", b"just buy 1$ worth of this coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000260419_33345e2e84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONEUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

