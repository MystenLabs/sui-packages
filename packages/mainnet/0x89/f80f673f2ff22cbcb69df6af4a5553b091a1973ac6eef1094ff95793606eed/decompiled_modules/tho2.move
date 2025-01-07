module 0x89f80f673f2ff22cbcb69df6af4a5553b091a1973ac6eef1094ff95793606eed::tho2 {
    struct THO2 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<THO2>, arg1: 0x2::coin::Coin<THO2>) {
        0x2::coin::burn<THO2>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THO2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THO2>>(0x2::coin::mint<THO2>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<THO2>, arg1: &mut 0x2::coin::CoinMetadata<THO2>, arg2: 0x1::string::String) {
        0x2::coin::update_name<THO2>(arg0, arg1, arg2);
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<THO2>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO2>>(arg0, arg1);
    }

    fun init(arg0: THO2, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

