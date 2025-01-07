module 0x5e69df8c093d1f376d382014cceff7a76e70cbbec3b63dac342521f59f7f6031::suiblad {
    struct SUIBLAD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBLAD>, arg1: 0x2::coin::Coin<SUIBLAD>) {
        0x2::coin::burn<SUIBLAD>(arg0, arg1);
    }

    fun init(arg0: SUIBLAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBLAD>(arg0, 9, b"suiblad", b"sblad", b"t.me/suiblad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Qplus3J.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBLAD>>(v1);
        0x2::coin::mint_and_transfer<SUIBLAD>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBLAD>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBLAD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBLAD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

