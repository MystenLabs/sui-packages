module 0x894f99b86fa8baa84d86bbd0cd1771da4e7e054325285920c466091cb78245d1::glovo {
    struct GLOVO has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GLOVO>, arg1: 0x2::coin::Coin<GLOVO>) {
        assert!(false == false, 100);
        0x2::coin::burn<GLOVO>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GLOVO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<GLOVO>(0x2::coin::supply<GLOVO>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<GLOVO>>(0x2::coin::mint<GLOVO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GLOVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOVO>(arg0, 8, b"GLOVO", b"Glovo", b"Glovo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/Zy7oQX2zRF8ODGkT27kpRQz6hCub360vVlwMjJ8m-A4?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOVO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOVO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

