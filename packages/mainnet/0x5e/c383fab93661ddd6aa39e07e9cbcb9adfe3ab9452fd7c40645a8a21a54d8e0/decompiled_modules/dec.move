module 0x5ec383fab93661ddd6aa39e07e9cbcb9adfe3ab9452fd7c40645a8a21a54d8e0::dec {
    struct DEC has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEC>, arg1: 0x2::coin::Coin<DEC>) {
        assert!(false == false, 100);
        0x2::coin::burn<DEC>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<DEC>(0x2::coin::supply<DEC>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<DEC>>(0x2::coin::mint<DEC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEC>(arg0, 0, b"DEC", b"Decimala", b"DEC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/1tXUrpNL6XXySwRSQ6Vpb2T1zn-YJGpxMqN3KOtBoyQ?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

