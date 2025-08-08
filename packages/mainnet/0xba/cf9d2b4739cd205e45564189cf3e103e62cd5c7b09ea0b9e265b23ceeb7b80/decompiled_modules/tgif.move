module 0xbacf9d2b4739cd205e45564189cf3e103e62cd5c7b09ea0b9e265b23ceeb7b80::tgif {
    struct TGIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGIF>(arg0, 4, b"TGIF", b"TGIF on Friday", b"today is the last of the week", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.unsplash.com/photo-1590607244529-ee3e6dc7f65f?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TGIF>>(0x2::coin::mint<TGIF>(&mut v2, 3000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGIF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

