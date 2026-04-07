module 0x9a46f05166cac59bfcc7ad1e8c97f24f7c6f2fc36f894019e14ac5e5f84b3703::base_ce8 {
    struct BASE_CE8 has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &mut 0x2::coin::TreasuryCap<BASE_CE8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BASE_CE8> {
        0x2::coin::mint<BASE_CE8>(arg0, arg1, arg2)
    }

    public entry fun allocate_to(arg0: &mut 0x2::coin::TreasuryCap<BASE_CE8>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASE_CE8>>(0x2::coin::mint<BASE_CE8>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<BASE_CE8>, arg1: 0x2::coin::Coin<BASE_CE8>) {
        0x2::coin::burn<BASE_CE8>(arg0, arg1);
    }

    fun init(arg0: BASE_CE8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASE_CE8>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BASE_CE8>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASE_CE8>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

