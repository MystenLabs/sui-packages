module 0xb4d5882aeba34f38b7b98de0b5cc3ecf528c7689aff3924acc9c59dd761371b6::kaiken {
    struct KAIKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAIKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAIKEN>(arg0, 6, b"Kaiken", b"Kai ken the last inu", b"Other Inus, such as Shiba Inu, have built incredible communities, and KAI is working every single day to do the same", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiatulmzkbkturffwv7gnqobwzsmqjfzqvqah7npm5ix3sjqkk3uo4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAIKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAIKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

