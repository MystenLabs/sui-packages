module 0x858a62d292a4fe6dc73ab359b37aacd40d17d7ccd28a2e816b912c7ef2b92c92::mytktagn {
    struct MYTKTAGN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYTKTAGN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYTKTAGN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MYTKTAGN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeibkku7nsd7drr35scy35gdyvorilmnevzizxa752lw4ji6jtz4poe";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeibkku7nsd7drr35scy35gdyvorilmnevzizxa752lw4ji6jtz4poe"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<MYTKTAGN>(arg0, 9, b"MYTKTAGN", b"My token Tester Agn", b"A Test token that is not to have any actual value. Do not buy. Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<MYTKTAGN>>(0x2::coin::mint<MYTKTAGN>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYTKTAGN>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MYTKTAGN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MYTKTAGN>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

