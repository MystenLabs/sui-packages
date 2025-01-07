module 0x74a12ac3f60c7151061bb094e8343ae5e73276b0cbf874fc59d83b193d476df9::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIF>(arg0, 6, b"Suif", b"Suiba Wif Hat", b"Suiba Wif Hat $SUIF is here to take on the world with smiles and cuteness! His name is Suif, the first and only Suiba Inu on Sui chain and he comes Wif Hat. Let him take you on a journey you wont forget!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suif500x500_04f4da93fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

