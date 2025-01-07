module 0xbe59ad6c7067ae90bc8a1521b7186a21748787bb5dc949793dd1eb76fb127bac::corgi {
    struct CORGI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CORGI>, arg1: 0x2::coin::Coin<CORGI>) {
        0x2::coin::burn<CORGI>(arg0, arg1);
    }

    fun init(arg0: CORGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORGI>(arg0, 6, b"CORGI", b"CORGI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://corgisui.xyz/corgi.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORGI>>(v1);
        0x2::coin::mint_and_transfer<CORGI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORGI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CORGI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CORGI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

