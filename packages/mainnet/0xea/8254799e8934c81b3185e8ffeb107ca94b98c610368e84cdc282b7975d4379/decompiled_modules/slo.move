module 0xea8254799e8934c81b3185e8ffeb107ca94b98c610368e84cdc282b7975d4379::slo {
    struct SLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SLO>(arg0, 2, b"SLO", b"SLO Token", b"SLO SLO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiepkmnmiwdxsvsldfefghfwkr2fzyrtaybfdx5nbmsynbdmppqd6q.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SLO>>(v1, @0xcb212ae2406d6f11a63ba5abe6a57a44ac53a021db1fa528365208e93d3ac145);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SLO>(&mut v3, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLO>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun majo(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SLO>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<SLO>(arg0, v1)) {
                0x2::coin::deny_list_add<SLO>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

