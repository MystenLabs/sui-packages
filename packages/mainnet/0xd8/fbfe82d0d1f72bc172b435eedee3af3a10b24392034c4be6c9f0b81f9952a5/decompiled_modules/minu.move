module 0xd8fbfe82d0d1f72bc172b435eedee3af3a10b24392034c4be6c9f0b81f9952a5::minu {
    struct MINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINU>(arg0, 6, b"MINU", b"MI NU sui", b"Minu On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.pixabay.com/photo/2022/02/18/16/09/ape-7020995_1280.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

