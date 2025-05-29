module 0x6bbaeed6f1d53b7a4b9579915529a3f29f70b95a2c643b4961ac6792f2448804::ts8888 {
    struct TS8888 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TS8888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TS8888>(arg0, 6, b"Ts8888", b"Ts8888 Token", b"This is test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TS8888>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TS8888>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

