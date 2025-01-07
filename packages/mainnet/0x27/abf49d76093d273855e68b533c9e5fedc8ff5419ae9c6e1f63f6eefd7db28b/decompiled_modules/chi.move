module 0x27abf49d76093d273855e68b533c9e5fedc8ff5419ae9c6e1f63f6eefd7db28b::chi {
    struct CHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHI>(arg0, 9, b"Chi", b"SuiChi", x"53756963686920436f696e20546865206861707079206c6974746c6520627562626c652074686174e280997320726561647920746f20706f7020696e746f207468652053756920436861696e20756e697665727365212054656c656772616d3a2068747470733a2f2f742e6d652f5375694368695f537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728295583657-e48b3c974b9c72614c5b10b9d82de7f5.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

