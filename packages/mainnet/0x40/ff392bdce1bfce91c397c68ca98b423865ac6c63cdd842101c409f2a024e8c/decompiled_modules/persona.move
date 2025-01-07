module 0x40ff392bdce1bfce91c397c68ca98b423865ac6c63cdd842101c409f2a024e8c::persona {
    struct PERSONA has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PERSONA>, arg1: 0x2::coin::Coin<PERSONA>) {
        0x2::coin::burn<PERSONA>(arg0, arg1);
    }

    fun init(arg0: PERSONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PERSONA>(arg0, 6, b"PERSONA", b"Persona Art", b"Timefall Valley is calling. Will you answer?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.seadn.io/s/raw/files/0b6b937e62ff764713c2961af0b5e80b.png"))), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERSONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PERSONA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PERSONA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PERSONA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PERSONA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

