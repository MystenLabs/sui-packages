module 0xa42e826486988ddf732995b8a183c13fadda2f5ae9db2f2fbb88bbe902cb33e5::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<WOJAK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x47c40aed646f4d18233afd63ad21230144fa5b1c221be9ebb7a7971d0b37bd37, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 6, b"Wojak", b"Wojak Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/FGJfXL8.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v0, @0x47c40aed646f4d18233afd63ad21230144fa5b1c221be9ebb7a7971d0b37bd37);
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<WOJAK>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x47c40aed646f4d18233afd63ad21230144fa5b1c221be9ebb7a7971d0b37bd37, 1);
        0x2::coin::mint_and_transfer<WOJAK>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

