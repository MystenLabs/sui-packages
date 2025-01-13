module 0xb4a52fd3a9d517eb67280bb0c90dc0048d721374e38e8f4779fec8c76a40c4da::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ASD>, arg1: 0x2::coin::Coin<ASD>) {
        assert!(false == false, 100);
        0x2::coin::burn<ASD>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<ASD>(0x2::coin::supply<ASD>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<ASD>>(0x2::coin::mint<ASD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 0, b"ASD", b"ASDA", b"ASD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/-6CRTRKuc4lZbQ8e-gNH0u3TknyPU6xaXLU_BdN8BaE?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

