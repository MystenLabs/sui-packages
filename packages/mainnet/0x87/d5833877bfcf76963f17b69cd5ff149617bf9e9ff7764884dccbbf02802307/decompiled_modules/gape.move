module 0x87d5833877bfcf76963f17b69cd5ff149617bf9e9ff7764884dccbbf02802307::gape {
    struct GAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAPE>(arg0, 6, b"GAPE", b"Green Ape Coin", b"Telegram: https://t.me/gape_sui . Launch: 2:30 PM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/a95Sx1P.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAPE>>(v0, @0x716dd81a65efa8e9a0bce07f0953f120f357b5bbe5ec53986fcc3819d90ef9e5);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GAPE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GAPE>(arg0, arg1, @0x716dd81a65efa8e9a0bce07f0953f120f357b5bbe5ec53986fcc3819d90ef9e5, arg2);
    }

    // decompiled from Move bytecode v6
}

