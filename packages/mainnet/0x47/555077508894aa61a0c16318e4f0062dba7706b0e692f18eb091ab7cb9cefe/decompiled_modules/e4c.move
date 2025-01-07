module 0x47555077508894aa61a0c16318e4f0062dba7706b0e692f18eb091ab7cb9cefe::e4c {
    struct E4C has drop {
        dummy_field: bool,
    }

    fun init(arg0: E4C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E4C>(arg0, 6, b"E4C", b"$E4C regular pool", b"E4C is a gaming ecosystem on Sui built to become the bridge between web2 and web3 gaming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732636256180.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<E4C>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<E4C>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

