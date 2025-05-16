module 0x918b6923b392f8dd281e7078ac565378e65880b6fe9eb89adfb9604a03fd8859::privatecoin {
    struct PRIVATECOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PRIVATECOIN>, arg1: 0x2::coin::Coin<PRIVATECOIN>) {
        0x2::coin::burn<PRIVATECOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIVATECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIVATECOIN>>(0x2::coin::mint<PRIVATECOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIVATECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIVATECOIN>(arg0, 9, b"USDT ", b"Tather USD", b"yulezhuanyong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.gtokentool.com/1738779065/1.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIVATECOIN>>(v1);
        let v3 = &mut v2;
        mint(v3, 5901314000000000, @0x188915d15c4640fb2517e1ec0753ef8f29e9018350be69160eb3f84723ffaeea, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIVATECOIN>>(v2, @0x188915d15c4640fb2517e1ec0753ef8f29e9018350be69160eb3f84723ffaeea);
    }

    // decompiled from Move bytecode v6
}

