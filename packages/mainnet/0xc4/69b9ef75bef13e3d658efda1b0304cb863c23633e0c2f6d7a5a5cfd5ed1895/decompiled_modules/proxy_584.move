module 0xc469b9ef75bef13e3d658efda1b0304cb863c23633e0c2f6d7a5a5cfd5ed1895::proxy_584 {
    struct PROXY_584 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROXY_584>, arg1: 0x2::coin::Coin<PROXY_584>) {
        0x2::coin::burn<PROXY_584>(arg0, arg1);
    }

    fun init(arg0: PROXY_584, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROXY_584>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROXY_584>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROXY_584>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<PROXY_584>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROXY_584> {
        0x2::coin::mint<PROXY_584>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<PROXY_584>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROXY_584>>(0x2::coin::mint<PROXY_584>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

