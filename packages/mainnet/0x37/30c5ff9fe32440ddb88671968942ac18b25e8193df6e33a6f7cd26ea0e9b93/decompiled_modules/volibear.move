module 0x3730c5ff9fe32440ddb88671968942ac18b25e8193df6e33a6f7cd26ea0e9b93::volibear {
    struct VOLIBEAR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<VOLIBEAR>, arg1: 0x2::coin::Coin<VOLIBEAR>) {
        0x2::coin::burn<VOLIBEAR>(arg0, arg1);
    }

    fun init(arg0: VOLIBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLIBEAR>(arg0, 2, b"VLBR", b"Volibear", b"Coin of Volibear - a champion in League of Legends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://1.bp.blogspot.com/-J1yJ0gErIgU/XrsQxL43HaI/AAAAAAABkMg/Yi2suK5PM4YVHaD0hnpx4zq7M1m6_9LnQCLcBGAsYHQ/s200/Volibear_Icon_R.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOLIBEAR>>(v1);
        0x2::coin::mint_and_transfer<VOLIBEAR>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLIBEAR>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VOLIBEAR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VOLIBEAR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

