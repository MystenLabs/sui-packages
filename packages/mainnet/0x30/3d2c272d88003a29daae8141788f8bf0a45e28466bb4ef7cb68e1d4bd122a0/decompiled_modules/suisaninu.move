module 0x303d2c272d88003a29daae8141788f8bf0a45e28466bb4ef7cb68e1d4bd122a0::suisaninu {
    struct SUISANINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISANINU>, arg1: 0x2::coin::Coin<SUISANINU>) {
        0x2::coin::burn<SUISANINU>(arg0, arg1);
    }

    fun init(arg0: SUISANINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISANINU>(arg0, 9, b"suisan inu", b"SINU", b"Susan or Nasus God or Dog one thing is sure SUISAN is both", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/a/cLGnObz")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISANINU>>(v1);
        0x2::coin::mint_and_transfer<SUISANINU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISANINU>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISANINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISANINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

