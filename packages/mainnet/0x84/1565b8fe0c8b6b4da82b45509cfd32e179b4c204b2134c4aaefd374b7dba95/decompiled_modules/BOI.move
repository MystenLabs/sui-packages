module 0x841565b8fe0c8b6b4da82b45509cfd32e179b4c204b2134c4aaefd374b7dba95::BOI {
    struct BOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOI>(arg0, 6, b"BOI", b"Weather Boi", b"Wouldn't you like to know weather boi????", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmUr9iDCNxZvt4c7HenoDwf1zzrWVeMS9ApCcmqA7c5C73")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

