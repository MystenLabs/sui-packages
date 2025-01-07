module 0xe44bf3a3a641c9f89ce025dd1bb73943854af809ee68234dbc607e0a1f9f70fd::BEJING {
    struct BEJING has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEJING>, arg1: 0x2::coin::Coin<BEJING>) {
        0x2::coin::burn<BEJING>(arg0, arg1);
    }

    fun init(arg0: BEJING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEJING>(arg0, 9, b"BEJING", b"Bejing", b"Bejing Memecoin! Welcome to china coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/hy9NL8w/bejing.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEJING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEJING>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEJING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BEJING>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

