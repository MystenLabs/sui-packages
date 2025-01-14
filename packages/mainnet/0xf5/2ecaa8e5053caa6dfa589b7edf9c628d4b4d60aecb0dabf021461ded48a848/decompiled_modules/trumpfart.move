module 0xf52ecaa8e5053caa6dfa589b7edf9c628d4b4d60aecb0dabf021461ded48a848::trumpfart {
    struct TRUMPFART has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPFART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPFART>(arg0, 9, b"TRUMPFART", b"Trumpfart", b"The farts of our 47th President!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmT3DQ2aCDZPQp7RTHtBgc3QJPk1z2QHsAioFjTzfFDRKW")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPFART>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPFART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPFART>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

