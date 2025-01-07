module 0x52f1646bb8638f2fe74c58c1504e7be17855c6be42dd64ddff3c7f73506172e5::sui_sea_spin {
    struct SUI_SEA_SPIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_SEA_SPIN>, arg1: 0x2::coin::Coin<SUI_SEA_SPIN>) {
        0x2::coin::burn<SUI_SEA_SPIN>(arg0, arg1);
    }

    fun init(arg0: SUI_SEA_SPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SEA_SPIN>(arg0, 9, b"SSS", b"Sui Sea Spin", b"Sui Sea Spin is a utility token for the Sui Sea Spin casino dapp. It allows users to play poker using the token as the in-game currency. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/FX61bfj/photo-2024-10-04-11-11-51.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_SEA_SPIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_SEA_SPIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_SEA_SPIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI_SEA_SPIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

