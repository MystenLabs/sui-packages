module 0x728aed972c608f3714662477392b743a3870e0faa67a4d49fb155d43ea029efe::moaner {
    struct MOANER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOANER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOANER>(arg0, 6, b"MOANER", b"Moaner Slime", b"Meet $MOANER Melter Slime the new character revealed by Matt Furie's editor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih2zeyqupzkjy7gpuhbnyir27erhu756yau47c3dvk5kxqjdktf6q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOANER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOANER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

