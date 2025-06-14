module 0xab645f3b0b86d505643e0ff0fb7464cd24d91b1b2fb1cbd0ad1a457f222ae80c::PSI {
    struct PSI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PSI>, arg1: 0x2::coin::Coin<PSI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PSI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PSI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PSI>>(0x2::coin::mint<PSI>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<PSI>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PSI>>(arg0);
    }

    fun init(arg0: PSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSI>(arg0, 9, b"PSI", b"PASIVE INCOME", b"Pasive Income Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bluehost.com/blog/wp-content/uploads/2024/01/Passive-income-ideas.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

