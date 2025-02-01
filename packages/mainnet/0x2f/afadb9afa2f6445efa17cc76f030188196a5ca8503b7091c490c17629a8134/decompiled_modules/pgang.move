module 0x2fafadb9afa2f6445efa17cc76f030188196a5ca8503b7091c490c17629a8134::pgang {
    struct PGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGANG>(arg0, 9, b"PGANG", b"Pepe Gang", b"Join the gang and let Pepe lead your portfolio to gains so big, even the haters will want to ribbit in!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/x4HCIHAa1DJo5G3i")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PGANG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PGANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGANG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

