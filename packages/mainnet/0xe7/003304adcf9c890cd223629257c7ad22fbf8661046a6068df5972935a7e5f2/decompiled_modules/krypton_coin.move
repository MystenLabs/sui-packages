module 0xe7003304adcf9c890cd223629257c7ad22fbf8661046a6068df5972935a7e5f2::krypton_coin {
    struct KRYPTON_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRYPTON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRYPTON_COIN>(arg0, 9, b"krypton", b"KRYPTON_COIN", b"Krypton Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/154910746?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRYPTON_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRYPTON_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KRYPTON_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KRYPTON_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

