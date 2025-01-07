module 0xa9902e46093ebcf57dc88dd959f5c6392d1c6afc9f848b1d1d0e241daea8525b::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"Chad", b"ChadonSui", x"446f6e2774204d69737320596f7572204368616e636520417420416e20416d617a696e67204f70706f7274756e6974792e2e2e0a0a506570652773206c6f6e67206c6f7374205477696e2042726f746865722024436861640a0a536f6369616c7320636f6d696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017373_122e16d3fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

