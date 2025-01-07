module 0xf769618dc8f59817faa4e87ce78670b9156bffd002fa2bf2c52b5dd62cc4dd1d::marshlilycoin {
    struct MARSHLILYCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MARSHLILYCOIN>, arg1: 0x2::coin::Coin<MARSHLILYCOIN>) {
        0x2::coin::burn<MARSHLILYCOIN>(arg0, arg1);
    }

    fun init(arg0: MARSHLILYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARSHLILYCOIN>(arg0, 9, b"marshlilycoin", b"MLC", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/h5SB4vh.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARSHLILYCOIN>>(v1);
        0x2::coin::mint_and_transfer<MARSHLILYCOIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARSHLILYCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MARSHLILYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MARSHLILYCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

