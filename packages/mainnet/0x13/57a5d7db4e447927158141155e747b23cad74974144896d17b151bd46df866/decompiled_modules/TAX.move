module 0x1357a5d7db4e447927158141155e747b23cad74974144896d17b151bd46df866::TAX {
    struct TAX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TAX>, arg1: 0x2::coin::Coin<TAX>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TAX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TAX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TAX>>(0x2::coin::mint<TAX>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TAX>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TAX>>(arg0);
    }

    fun init(arg0: TAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAX>(arg0, 9, b"TAX", b"Tax Coin", b"The only coin on SUI that is taxed in a way to reward holders and PUNISH Jeets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68eb7c5230a4a5.28955704.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

