module 0x796399082b501918de4b157ac6877b85735bdad426244a53585ba440b4061faa::hzol {
    struct HZOL has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<HZOL>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<HZOL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HZOL>>(arg0, arg1);
    }

    public entry fun burn_coin(arg0: &mut TreasuryCapHolder, arg1: 0x2::coin::Coin<HZOL>) {
        0x2::coin::burn<HZOL>(&mut arg0.treasury_cap, arg1);
    }

    fun init(arg0: HZOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HZOL>(arg0, 9, b"HZOL", b"Hzol", b"Native Currency of HZOL Protocol!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/dLkSZMp/gorilla.jpg"))), arg1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::coin::mint_and_transfer<HZOL>(&mut v2.treasury_cap, 10000000000000000000, @0xd1deff6ee20b10987bfe8d50f70f893e0465f0d00bcb638c19ad979d83f1c9c0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HZOL>>(v1);
        0x2::transfer::transfer<TreasuryCapHolder>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

