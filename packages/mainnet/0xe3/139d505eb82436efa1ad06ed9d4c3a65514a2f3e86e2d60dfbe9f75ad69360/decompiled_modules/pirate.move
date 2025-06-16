module 0xe3139d505eb82436efa1ad06ed9d4c3a65514a2f3e86e2d60dfbe9f75ad69360::pirate {
    struct PIRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRATE>(arg0, 6, b"PIRATE", b"Piratecat", b"Its a pirate. Its a cat. Its a piratecat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifweliurooz76aq2z5lgilridwdxzhctvemv4qqexoc3v3n37cod4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIRATE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

