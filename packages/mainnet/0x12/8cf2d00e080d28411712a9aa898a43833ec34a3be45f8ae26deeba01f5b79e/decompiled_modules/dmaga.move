module 0x128cf2d00e080d28411712a9aa898a43833ec34a3be45f8ae26deeba01f5b79e::dmaga {
    struct DMAGA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DMAGA>, arg1: 0x2::coin::Coin<DMAGA>) {
        0x2::coin::burn<DMAGA>(arg0, arg1);
    }

    fun init(arg0: DMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMAGA>(arg0, 9, b"DMAGA", b"DARK MAGA", b"Make America Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQzLo35YsfZQU9cwXEP6pM7UZjM9qY8ghP4fwoBLf2zZx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DMAGA>(&mut v2, 25000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMAGA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DMAGA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DMAGA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

