module 0x6e9f8614fc341fa90ad0cdff6f486cd800906ed0bc6451ec12c4ca4c910b49f8::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<WHALE>(arg0, 6, b"WHALE", b"Matt Furie's $WHALE", b"$Whale and its CTO's appeared a magnificent project, though time showed it was run by shady dev's. This replica is built on one principle, INTEGRITY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whale_icon_c192d23c04.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<WHALE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v2);
    }

    // decompiled from Move bytecode v6
}

