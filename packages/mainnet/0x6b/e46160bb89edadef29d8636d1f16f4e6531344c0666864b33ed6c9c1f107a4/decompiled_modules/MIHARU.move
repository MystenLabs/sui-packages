module 0x6be46160bb89edadef29d8636d1f16f4e6531344c0666864b33ed6c9c1f107a4::MIHARU {
    struct MIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<MIHARU>(arg0, 2, b"MIHARU", b"MIHARU", b"MIHARU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/vaN0DaJvJzb5zSD2033L5498CXJtxEnpv7SbbX1a5jg?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIHARU>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<MIHARU>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<MIHARU>(&mut v3, 99993563760, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHARU>>(v3, @0x0);
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<MIHARU>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<MIHARU>(arg0, v1)) {
                0x2::coin::deny_list_add<MIHARU>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

