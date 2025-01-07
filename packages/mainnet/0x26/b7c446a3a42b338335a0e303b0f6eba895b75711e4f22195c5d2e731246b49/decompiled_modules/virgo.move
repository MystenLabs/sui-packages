module 0x26b7c446a3a42b338335a0e303b0f6eba895b75711e4f22195c5d2e731246b49::virgo {
    struct VIRGO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<VIRGO>, arg1: 0x2::coin::Coin<VIRGO>) {
        0x2::coin::burn<VIRGO>(arg0, arg1);
    }

    fun init(arg0: VIRGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIRGO>(arg0, 6, b"VIRGO", b"VIRGOTOKEN", b"VIRGO DEFI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAbBpb-wuw-ErY5xvnDCTRC57qONWy0KRGoQ&usqp=CAU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIRGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIRGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VIRGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VIRGO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

