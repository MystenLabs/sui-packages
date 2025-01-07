module 0xcce32a6b24c1455109d9e888063d46df0a9cc5308bdbd25f343c8b7386ef36e5::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUCK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUCK>>(0x2::coin::split<SUCK>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<SUCK>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUCK>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUCK>(arg0);
        };
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 9, b"SUCK", b"Suck The Duck", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://suckduck.xyz/suck_logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUCK>>(0x2::coin::mint<SUCK>(&mut v2, 8181054663000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

