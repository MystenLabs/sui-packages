module 0x4ae2cbfef2fcbef830f75103088165eda5806a30f6e676543be316b109b02f37::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 6, b"WIF", b"Wif on Sui", b"First dog wif hat on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731593839028.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

