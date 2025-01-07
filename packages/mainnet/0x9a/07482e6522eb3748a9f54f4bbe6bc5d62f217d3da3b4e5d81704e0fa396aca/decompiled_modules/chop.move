module 0x9a07482e6522eb3748a9f54f4bbe6bc5d62f217d3da3b4e5d81704e0fa396aca::chop {
    struct CHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP>(arg0, 9, b"CHOP", b"Chop Sui", b"The Axe forgets but the Sui doesn't", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/gallery/5PTOsOD")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHOP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

