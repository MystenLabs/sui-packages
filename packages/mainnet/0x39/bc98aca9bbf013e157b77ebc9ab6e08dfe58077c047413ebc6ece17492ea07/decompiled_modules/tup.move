module 0x39bc98aca9bbf013e157b77ebc9ab6e08dfe58077c047413ebc6ece17492ea07::tup {
    struct TUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUP>(arg0, 6, b"Tup", b"Tenup", b"A Decentralized Platform for Web3 Dapps. When the world is DECENTRALIZING, You should too.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731862431901.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

