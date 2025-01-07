module 0x14cc56d7dcadae69c88274103393386c208f24a4dbc32367219973822baa272f::geko {
    struct GEKO has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<GEKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GEKO>>(0x2::coin::split<GEKO>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<GEKO>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<GEKO>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<GEKO>(arg0);
        };
    }

    fun init(arg0: GEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEKO>(arg0, 9, b"GEKO", b"GEKO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.prod.website-files.com/669f0dacd341140b57fa4f77/669f1c3ee7573029c04fcdde_1s_silver.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEKO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GEKO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<GEKO>>(0x2::coin::mint<GEKO>(&mut v2, 4000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

