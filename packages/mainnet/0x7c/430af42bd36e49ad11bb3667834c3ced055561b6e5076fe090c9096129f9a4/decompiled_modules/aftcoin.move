module 0x7c430af42bd36e49ad11bb3667834c3ced055561b6e5076fe090c9096129f9a4::aftcoin {
    struct AFTCOIN has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        aft_supply: 0x2::balance::Supply<AFTCOIN>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<AFTCOIN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AFTCOIN>>(arg0, arg1);
    }

    fun init(arg0: AFTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFTCOIN>(arg0, 9, b"AFT", b"AFTCOIN", b"Native Currency of AFT Protocol!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/pvyLdDh/animal.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFTCOIN>>(v1);
        0x2::coin::mint_and_transfer<AFTCOIN>(&mut v2, 10000000000000000000, @0x8f6ff638438081e30f3c823e83778118947e617f9d8ab08eca8613d724d77335, arg1);
        let v3 = Treasury{
            id         : 0x2::object::new(arg1),
            aft_supply : 0x2::coin::treasury_into_supply<AFTCOIN>(v2),
        };
        0x2::transfer::freeze_object<Treasury>(v3);
    }

    // decompiled from Move bytecode v6
}

