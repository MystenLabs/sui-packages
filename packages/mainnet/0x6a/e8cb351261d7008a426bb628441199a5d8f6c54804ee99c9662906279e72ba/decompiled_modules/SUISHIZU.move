module 0x6ae8cb351261d7008a426bb628441199a5d8f6c54804ee99c9662906279e72ba::SUISHIZU {
    struct SUISHIZU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISHIZU>, arg1: 0x2::coin::Coin<SUISHIZU>) {
        0x2::coin::burn<SUISHIZU>(arg0, arg1);
    }

    fun init(arg0: SUISHIZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIZU>(arg0, 9, b"SHIZU", b"Sui Shizu", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/Bz9n9VH/240px-Shizuka.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIZU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIZU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISHIZU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISHIZU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

