module 0xeeedd78de319c624bd5c7bda195f385dc847a2917d6bc3ba050d3424df2c12f2::satoshivm {
    struct SATOSHIVM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHIVM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHIVM>(arg0, 9, b"SAVM", b"SatoshiVM", b"https://twitter.com/SatoshiVM, https://www.satoshivm.io/,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/Nj7cwgV3/satoshi-VM.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATOSHIVM>>(v1);
        0x2::coin::mint_and_transfer<SATOSHIVM>(&mut v2, 52500000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHIVM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

