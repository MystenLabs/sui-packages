module 0x9ed1e42ee883059347aeb7d613a01936fa85435bf51fa103763435529fa10d22::zorp {
    struct ZORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORP>(arg0, 6, b"ZORP", b"ZORP on SUI", x"54686520467269656e646c7920616c69656e2066726f6d20706c616e657420736f6c616e6120746861742077616e747320746f206d69677261746520696e20737569206f6365616e2e200a0a4d61646520666f722066756e2c286e6f2058206e6f2074672c20796f752063616e2063746f2074686973292062757920696620796f752077616e742e20692077696c6c206a757374206275726e207468652068616c66206f66206d7920737570706c792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0877_b7fb6fb299.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZORP>>(v1);
    }

    // decompiled from Move bytecode v6
}

