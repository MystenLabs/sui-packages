module 0x207faf861177d3a44244ef46ff947a8c36c8e149071fd3db749a020f27afaba::dge {
    struct DGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGE>(arg0, 6, b"DGE", b"DGE", b"Dept Of Government Efficiency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/501-3WneGXKjzaSDMkVzS7RExjGDzRF1Hr2R4F9iDoCFpump-98.png/type=default_350_0?v=1736139962512&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DGE>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

