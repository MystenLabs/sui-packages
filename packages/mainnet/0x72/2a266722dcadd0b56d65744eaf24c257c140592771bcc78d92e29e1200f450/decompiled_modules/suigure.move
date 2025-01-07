module 0x722a266722dcadd0b56d65744eaf24c257c140592771bcc78d92e29e1200f450::suigure {
    struct SUIGURE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIGURE>, arg1: 0x2::coin::Coin<SUIGURE>) {
        0x2::coin::burn<SUIGURE>(arg0, arg1);
    }

    fun init(arg0: SUIGURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGURE>(arg0, 9, b"suigure", b"$9mm", b"Suigure shoots around", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGURE>>(v1);
        0x2::coin::mint_and_transfer<SUIGURE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGURE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIGURE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIGURE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

