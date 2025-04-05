module 0xedc6c99d55b03607a55738f241a552a6c5c21169b76590c23e02ee6b1a77d16d::szlng {
    struct SZLNG has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SZLNG>, arg1: 0x2::coin::Coin<SZLNG>) {
        assert!(true == false, 100);
        0x2::coin::burn<SZLNG>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SZLNG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<SZLNG>(0x2::coin::supply<SZLNG>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SZLNG>>(0x2::coin::mint<SZLNG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SZLNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZLNG>(arg0, 9, b"SZLNG", b"Sizzling Sausages", x"416c7761797320486f742c204e657665722046726f7a656e2e0d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/RmxkeetwYecnKCrGxF56cE2iOak1__1VM7HCwFPsP2I?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SZLNG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZLNG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

