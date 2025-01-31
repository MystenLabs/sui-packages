module 0x1301065c0df290824df037c6e6607122ff7e6acb8ed5bdc0a36f54f37f2addd0::gno {
    struct GNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNO>(arg0, 9, b"GNO", x"47656e75c2b7696e6f", b"The unic NFT of all blockchains. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7358d89f6ccfd9e7b6cfd01eccb94b3ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GNO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

