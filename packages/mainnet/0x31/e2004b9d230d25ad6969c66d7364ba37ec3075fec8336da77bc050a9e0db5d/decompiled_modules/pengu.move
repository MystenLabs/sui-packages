module 0x31e2004b9d230d25ad6969c66d7364ba37ec3075fec8336da77bc050a9e0db5d::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"PENGU", b"Pengu Printer", x"546865206669727374206d656d652074686174206d616b657320766964656f206c6976657320696e736964652061203344207072696e746572210a4c65742773205052525252494e542120245052494e5445522e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig7fp62qrwc4kjahacfjnqhp3za4xxmjcfd6nlb4prbrkf7xrzed4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENGU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

