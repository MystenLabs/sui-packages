module 0xc81416de9761fb8693d54d38267823c0a87f64f46f92f125fddb0977e36168b6::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"OFFICIAL TRUMP", b"6p6xgHyF7AeE6TZkSmFsko444wqoP15icUSqi2jfGiPN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://statics.solscan.io/cdn/imgs/s60?ref=68747470733a2f2f617277656176652e6e65742f565172506a4143776e51526d78644b4254714e775069796f363578374c415437373374384b643759427a77")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

