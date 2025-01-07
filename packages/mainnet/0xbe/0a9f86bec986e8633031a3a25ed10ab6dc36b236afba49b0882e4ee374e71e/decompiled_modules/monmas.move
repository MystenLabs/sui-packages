module 0xbe0a9f86bec986e8633031a3a25ed10ab6dc36b236afba49b0882e4ee374e71e::monmas {
    struct MONMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONMAS>(arg0, 6, b"MONMAS", b"Monkey Blue Christmas", b"Monkey christmas first monkey blue ready take a part on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009116_5cc49ece14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

