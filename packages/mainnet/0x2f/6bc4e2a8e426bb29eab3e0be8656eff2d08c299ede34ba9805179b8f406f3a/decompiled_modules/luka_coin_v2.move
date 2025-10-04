module 0x2f6bc4e2a8e426bb29eab3e0be8656eff2d08c299ede34ba9805179b8f406f3a::luka_coin_v2 {
    struct LUKA_COIN_V2 has drop {
        dummy_field: bool,
    }

    struct LukaTreasury2 has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<LUKA_COIN_V2>,
    }

    entry fun mint(arg0: &mut LukaTreasury2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUKA_COIN_V2>>(0x2::coin::mint<LUKA_COIN_V2>(&mut arg0.cap, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: LUKA_COIN_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUKA_COIN_V2>(arg0, 9, b"LUKA", b"LUKA", b"LUKA MEMECOIN", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUKA_COIN_V2>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = LukaTreasury2{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::public_transfer<LukaTreasury2>(v2, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_to(arg0: &mut LukaTreasury2, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUKA_COIN_V2>>(0x2::coin::mint<LUKA_COIN_V2>(&mut arg0.cap, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

