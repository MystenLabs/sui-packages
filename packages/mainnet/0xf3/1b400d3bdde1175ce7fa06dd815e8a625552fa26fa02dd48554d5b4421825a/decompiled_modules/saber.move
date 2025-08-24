module 0xf31b400d3bdde1175ce7fa06dd815e8a625552fa26fa02dd48554d5b4421825a::saber {
    struct SABER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: 0x2::coin::Coin<SABER>) {
        0x2::balance::destroy_zero<SABER>(0x2::coin::into_balance<SABER>(arg0));
    }

    fun init(arg0: SABER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SABER>(arg0, 9, b"SABER", b"SaberSama", b"SaberSama on the SUI Blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreifuc4r3btg6oddccbhxqac7shmff43ngn4gprrtptiktodftkjy24")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SABER>>(v1);
        0x2::coin::mint_and_transfer<SABER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SABER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

