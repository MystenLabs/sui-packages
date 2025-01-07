module 0xbf49301e080aaf04d064c4a189e479d62400d0059a7991987aa5e033ba1754a8::buddy {
    struct BUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDDY>(arg0, 6, b"BUDDY", b"BUDDY SUI", b"buddythewhale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29c158a1fcc735346352153466750d05_6f0334ebbf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

