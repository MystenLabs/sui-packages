module 0x86ca14162a8ecf3dc0d809c06d814ebc3fa84ad4032725bb426da937af175503::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PUMP>(arg0, 9, b"GITBANK", b"Gitbank", x"412053756920636f6d6d756e69747920746f6b656e206c61756e636865642077697468206f6e6520636c69636b2e0af09f8c902068747470733a2f2f67697462616e6b2e696f2f0af09d958f2068747470733a2f2f782e636f6d2f47697462616e6b5f696f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.clanker.world/_next/image?url=https%3A%2F%2Fturquoise-blank-swallow-685.mypinata.cloud%2Fipfs%2Fbafkreifdnzss5seszogtkqjqeviecukeecgt3rniwpbol4whrftdlmtjje&w=48&q=75")), true, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP>>(0x2::coin::mint<PUMP>(&mut v3, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMP>>(v2, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PUMP>>(v1, @0x0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v3, @0x0);
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<PUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP>>(0x2::coin::mint<PUMP>(arg0, arg1, arg3), arg2);
    }

    public entry fun pause_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PUMP>(arg0, arg1, arg2, arg3);
    }

    public entry fun pause_all(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<PUMP>(arg0, arg1, arg2);
    }

    public entry fun resume_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PUMP>(arg0, arg1, arg2, arg3);
    }

    public entry fun resume_all(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_disable_global_pause<PUMP>(arg0, arg1, arg2);
    }

    public entry fun revoke_all(arg0: 0x2::coin::TreasuryCap<PUMP>, arg1: 0x2::coin::CoinMetadata<PUMP>, arg2: 0x2::coin::DenyCapV2<PUMP>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(arg0, @0x0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMP>>(arg1, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PUMP>>(arg2, @0x0);
    }

    // decompiled from Move bytecode v7
}

