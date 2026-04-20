module 0x25f4e19c6058aee69ce8dbaef310438f71f7a1a07a08593f3b94218c646e077d::proxy {
    struct PROXY has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROXY>, arg1: 0x2::coin::Coin<PROXY>) {
        0x2::coin::burn<PROXY>(arg0, arg1);
    }

    public fun forge(arg0: &mut 0x2::coin::TreasuryCap<PROXY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROXY> {
        0x2::coin::mint<PROXY>(arg0, arg1, arg2)
    }

    public entry fun forge_to(arg0: &mut 0x2::coin::TreasuryCap<PROXY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROXY>>(0x2::coin::mint<PROXY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PROXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROXY>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROXY>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROXY>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

