module 0xcff842a363e1f641b4b5522caf4b1db16911fc6062dd17a06738f99cba9e2cbd::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AGENT>, arg1: 0x2::coin::Coin<AGENT>) {
        assert!(true == false, 100);
        0x2::coin::burn<AGENT>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AGENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<AGENT>(0x2::coin::supply<AGENT>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<AGENT>>(0x2::coin::mint<AGENT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 5, b"AGENT", b"AGENT", b"AGENT token created via SUI Surfer agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/R-TG2q7XtqxJ9miGvZl175T58chslCH_UrACaLVhJRw?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

