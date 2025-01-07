module 0xd1f6cad2cd32b1e3adba8501b71243afd1d24a89bce3ef48b4d6cd75439c57ee::staging_maya {
    struct STAGING_MAYA has drop {
        dummy_field: bool,
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<STAGING_MAYA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STAGING_MAYA>>(0x2::coin::mint<STAGING_MAYA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STAGING_MAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAGING_MAYA>(arg0, 0, b"STAGING_MAYA", b"Maya", b"ChakraNFT farming token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://arweave.net/kWSJZuBdbW204H0bimVYzW1KFBbzVrrt1VWOEXuarqs"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAGING_MAYA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAGING_MAYA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

