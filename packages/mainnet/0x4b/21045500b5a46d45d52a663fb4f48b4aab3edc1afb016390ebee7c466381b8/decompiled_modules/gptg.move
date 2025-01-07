module 0x4b21045500b5a46d45d52a663fb4f48b4aab3edc1afb016390ebee7c466381b8::gptg {
    struct GPTG has drop {
        dummy_field: bool,
    }

    struct BurnCap has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<GPTG>,
    }

    public entry fun burn(arg0: &mut BurnCap, arg1: 0x2::coin::Coin<GPTG>) : u64 {
        0x2::coin::burn<GPTG>(&mut arg0.treasury, arg1)
    }

    fun init(arg0: GPTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPTG>(arg0, 6, b"GPTG", b"GPT Guru", b"AI PoweredBlockchainGPT Solution. powerd by https://gptguru.io/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/top1st/token-assets/main/png/gptg.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GPTG>>(v1);
        0x2::coin::mint_and_transfer<GPTG>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = BurnCap{
            id       : 0x2::object::new(arg1),
            treasury : v2,
        };
        0x2::transfer::public_share_object<BurnCap>(v3);
    }

    // decompiled from Move bytecode v6
}

