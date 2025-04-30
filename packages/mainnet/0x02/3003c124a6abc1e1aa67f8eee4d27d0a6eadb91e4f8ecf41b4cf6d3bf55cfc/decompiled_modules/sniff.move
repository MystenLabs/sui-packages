module 0x23003c124a6abc1e1aa67f8eee4d27d0a6eadb91e4f8ecf41b4cf6d3bf55cfc::sniff {
    struct SNIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIFF>(arg0, 6, b"SNIFF", b"SNIFFCAT", b"the most memeable SUI cat on the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOJIORIG_101c1a49e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

