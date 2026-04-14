module 0x6cf941c83f9c53daa1ca27538dce4a6db6a502422ac57f42dbcdd35e2fd93f01::reserve_711 {
    struct RESERVE_711 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_711>, arg1: 0x2::coin::Coin<RESERVE_711>) {
        0x2::coin::burn<RESERVE_711>(arg0, arg1);
    }

    fun init(arg0: RESERVE_711, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESERVE_711>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RESERVE_711>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESERVE_711>>(v1);
    }

    public fun invoke(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_711>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RESERVE_711> {
        0x2::coin::mint<RESERVE_711>(arg0, arg1, arg2)
    }

    public entry fun invoke_to(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_711>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESERVE_711>>(0x2::coin::mint<RESERVE_711>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

