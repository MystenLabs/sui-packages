module 0xf5cf98635b5748beff06824dceba2354b899fa89b5d2a5019819afc453bf2b9c::luffyinu {
    struct LUFFYINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LUFFYINU>, arg1: 0x2::coin::Coin<LUFFYINU>) {
        0x2::coin::burn<LUFFYINU>(arg0, arg1);
    }

    fun init(arg0: LUFFYINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFYINU>(arg0, 6, b"LUFFY INU", b"LUFFYINU", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/BGR6YgH/luffy.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUFFYINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFYINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUFFYINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LUFFYINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

