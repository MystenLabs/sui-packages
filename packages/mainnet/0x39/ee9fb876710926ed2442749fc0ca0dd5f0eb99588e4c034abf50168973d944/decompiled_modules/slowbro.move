module 0x39ee9fb876710926ed2442749fc0ca0dd5f0eb99588e4c034abf50168973d944::slowbro {
    struct SLOWBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOWBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOWBRO>(arg0, 6, b"SLOWBRO", b"SLOW BRO", x"736c6f7762726f212120596f752064696420697421210a436f6d6d756e697479203a2068747470733a2f2f782e636f6d2f6a7573745f536c6f7762726f2f7374617475732f31393435303239313138393231313730393937", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiekfsmkkvendrx7lcfoz2gsudrkpbz5eg5yczoxna3eqbf4g44y3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOWBRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLOWBRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

