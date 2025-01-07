module 0x2ce3c8b59fb31fde117b82fcd1e9bc56963fdae9ce208dd592556c7092273970::dex {
    struct DEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEX>(arg0, 6, b"DEX", b"Dexter on Sui", x"446578746572206f6e20537569206973206865726520746f2068656c7020796f7520686176696e672046554e207768696c6520736f6c76696e67207265616c2050524f424c454d532e0a576520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731856497068.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

