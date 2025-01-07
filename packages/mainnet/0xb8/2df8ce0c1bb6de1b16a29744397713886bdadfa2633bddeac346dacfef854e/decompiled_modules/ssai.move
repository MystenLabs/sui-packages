module 0xb82df8ce0c1bb6de1b16a29744397713886bdadfa2633bddeac346dacfef854e::ssai {
    struct SSAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SSAI>, arg1: 0x2::coin::Coin<SSAI>) {
        0x2::coin::burn<SSAI>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<SSAI>, arg1: &mut 0x2::coin::Coin<SSAI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SSAI>(arg0, 0x2::coin::split<SSAI>(arg1, arg2, arg3));
    }

    fun init(arg0: SSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAI>(arg0, 6, b"SSAI", b"ShibaSUI AI", b"The first SHIBA AI Meme - NFTs - GameFi on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://nft-ai.shibasui.art/logo-128.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSAI>(&mut v2, 314000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

