module 0x687cc648bb3655cda5ad50a252db138acbc6045d51a094b26592f41a4b37a8bf::drmn {
    struct DRMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRMN>(arg0, 6, b"Drmn", b"Doraemon", b"emon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreier2oxio3qvrxykackpr2hplrmjc4xbc3uwqjd3vnifxcfd5cvcyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRMN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

