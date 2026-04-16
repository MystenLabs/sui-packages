module 0x8cb286c1de1ec1fcb27890f7e43440c5bba7d2e74d10d8a59d24a4c46a9dee29::proxy {
    struct PROXY has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROXY>, arg1: 0x2::coin::Coin<PROXY>) {
        0x2::coin::burn<PROXY>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<PROXY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROXY> {
        0x2::coin::mint<PROXY>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<PROXY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROXY>>(0x2::coin::mint<PROXY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PROXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROXY>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROXY>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROXY>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

