module 0xe16f7b9c3ddd885d7f0c7c39858515f6c5d9ac0e8f266cfad71ca8cf4370aa1e::flytam_coin {
    struct FLYTAM_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLYTAM_COIN>, arg1: 0x2::coin::Coin<FLYTAM_COIN>) {
        0x2::coin::burn<FLYTAM_COIN>(arg0, arg1);
    }

    fun init(arg0: FLYTAM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYTAM_COIN>(arg0, 6, b"flytam coin", b"flytam coin", b"Awesome Coint", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLYTAM_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYTAM_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLYTAM_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FLYTAM_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

