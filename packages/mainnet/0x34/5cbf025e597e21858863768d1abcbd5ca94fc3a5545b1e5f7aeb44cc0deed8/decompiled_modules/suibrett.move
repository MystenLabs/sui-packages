module 0x345cbf025e597e21858863768d1abcbd5ca94fc3a5545b1e5f7aeb44cc0deed8::suibrett {
    struct SUIBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBRETT>(arg0, 6, b"SUIBRETT", b"RISE OF SUIBRETT", b"suidi is my father", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihinth2fegfqz4sry4vsxhv3pwd6zshkwzcmk7bjlnjfpbuxbpocu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBRETT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

