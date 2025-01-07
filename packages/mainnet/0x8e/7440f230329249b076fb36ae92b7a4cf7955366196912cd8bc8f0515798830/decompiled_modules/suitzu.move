module 0x8e7440f230329249b076fb36ae92b7a4cf7955366196912cd8bc8f0515798830::suitzu {
    struct SUITZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITZU>(arg0, 6, b"Suitzu", b"Shih Tzu Wif Hat", b"Shih Tzu Wif Hat $Suitzu is here to take on the world with smiles and cuteness! His name is Suitzu, the first and only Shih Tzu on Sui chain and he comes Wif Hat. Let him take you on a journey you wont forget!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdsa132_93654bc8da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

