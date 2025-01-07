module 0xb8377144bf74828191292cd2f8594b0c75a6a870c3fd4623e9369df24fe2e6de::NOBI {
    struct NOBI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NOBI>, arg1: 0x2::coin::Coin<NOBI>) {
        0x2::coin::burn<NOBI>(arg0, arg1);
    }

    fun init(arg0: NOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBI>(arg0, 9, b"NOBI", b"Nobisui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/C2040vt/NOBI.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOBI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOBI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOBI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

