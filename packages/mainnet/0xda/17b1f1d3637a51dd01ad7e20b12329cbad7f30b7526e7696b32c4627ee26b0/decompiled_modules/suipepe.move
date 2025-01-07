module 0xda17b1f1d3637a51dd01ad7e20b12329cbad7f30b7526e7696b32c4627ee26b0::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPEPE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPEPE>>(0x2::coin::mint<SUIPEPE>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 9, b"SUIPEPE", b"H2O SUI PEPE", b"Representing the water Pepe on SUI ecosystem, good marketing behind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTb9Tj0Hd8rPM__ivRNrzu8V86LSTv27zvm4g&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPEPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

