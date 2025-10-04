module 0x6084602018d822421c9e90e94db95abdb8f625fc625fef1085ea518915ef43df::luka_coin_v2 {
    struct LUKA_COIN_V2 has drop {
        dummy_field: bool,
    }

    struct LukaTreasury2 has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<LUKA_COIN_V2>,
    }

    entry fun mint(arg0: &mut LukaTreasury2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUKA_COIN_V2>>(0x2::coin::mint<LUKA_COIN_V2>(&mut arg0.cap, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun mint_to(arg0: &mut LukaTreasury2, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUKA_COIN_V2>>(0x2::coin::mint<LUKA_COIN_V2>(&mut arg0.cap, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

