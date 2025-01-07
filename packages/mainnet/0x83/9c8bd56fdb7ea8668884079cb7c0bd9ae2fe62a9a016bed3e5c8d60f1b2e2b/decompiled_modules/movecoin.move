module 0x839c8bd56fdb7ea8668884079cb7c0bd9ae2fe62a9a016bed3e5c8d60f1b2e2b::movecoin {
    struct MOVECOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOVECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOVECOIN>>(0x2::coin::mint<MOVECOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOVECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVECOIN>(arg0, 6, b"yuanchengjiayu", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

