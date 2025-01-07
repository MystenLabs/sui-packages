module 0x2c41302f69494a1a50ae1120aa7f83e6d7ffe477b272af888a646879e801b8e6::neirok {
    struct NEIROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROK>(arg0, 6, b"NEIROK", b"Neiro Grok", b"NEIRO GRON ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23423423_508cfd54e8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

