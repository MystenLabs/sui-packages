module 0x66d336c419f837d9f3adc1c595f5ed6a3bf0b189ca159855005f35776b5d1671::igde {
    struct IGDE has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IGDE>, arg1: 0x2::coin::Coin<IGDE>) {
        assert!(false == false, 100);
        0x2::coin::burn<IGDE>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<IGDE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<IGDE>(0x2::coin::supply<IGDE>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<IGDE>>(0x2::coin::mint<IGDE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: IGDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGDE>(arg0, 5, b"IGDE", b"IGDEman", x"496764656d616ee2809920746f6b656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/UhPH4mEgViAEb0npPGslDvF-USghu6A3qkZVIrM1HxM?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IGDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

