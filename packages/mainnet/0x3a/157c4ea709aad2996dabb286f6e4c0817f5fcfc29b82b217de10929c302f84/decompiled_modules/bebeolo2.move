module 0x3a157c4ea709aad2996dabb286f6e4c0817f5fcfc29b82b217de10929c302f84::bebeolo2 {
    struct BEBEOLO2 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEBEOLO2>, arg1: 0x2::coin::Coin<BEBEOLO2>) {
        0x2::coin::burn<BEBEOLO2>(arg0, arg1);
    }

    fun init(arg0: BEBEOLO2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBEOLO2>(arg0, 2, b"BEBEOLO2", b"ktoiet2", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBEOLO2>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBEOLO2>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEBEOLO2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BEBEOLO2>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

