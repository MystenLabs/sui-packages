module 0x745056b1a7b8beb3df54fceb5409419d3413849d798c07a464d4e8e3c23624df::megasui {
    struct MEGASUI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEGASUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MEGASUI>>(0x2::coin::mint<MEGASUI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: MEGASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGASUI>(arg0, 9, b"symbol MEGA", b"token MEGASUI", b"FULLI GIGA MEGA SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEGASUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEGASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGASUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

