module 0x55bb777182b441ea78d587f5c906c419f0da8b48f64ba20f7a28732458ebd68::clm {
    struct CLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLM>(arg0, 9, b"CLM", b"Chill Language Model", b"A unique chill AI agent will help you find that very gem! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmco4dLJcfKkaQkvdvcu1CgLUKJ7SL2aEQEh9kW531TZq4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

