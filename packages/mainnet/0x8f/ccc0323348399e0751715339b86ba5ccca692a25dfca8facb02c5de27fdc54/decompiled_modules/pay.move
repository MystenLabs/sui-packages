module 0x8fccc0323348399e0751715339b86ba5ccca692a25dfca8facb02c5de27fdc54::pay {
    struct PAY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PAY>, arg1: 0x2::coin::Coin<PAY>) {
        0x2::coin::burn<PAY>(arg0, arg1);
    }

    fun init(arg0: PAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAY>(arg0, 6, b"PAY", b"LINKS", b"PLEASE USE THESE LINKS TO PAY IN SPACE. BE TRUE, BE KIND, BE HAPPY NOW V 1.0. NOT FINANCIAL ADVICE - USE AT YOUR OWN RISK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicwbnz5xneqsi5aqvttccczzhyxfjyeeihofksniiot5mpq4qib54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAY>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PAY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

