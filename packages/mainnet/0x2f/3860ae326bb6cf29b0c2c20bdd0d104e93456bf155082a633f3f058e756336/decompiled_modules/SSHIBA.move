module 0x2f3860ae326bb6cf29b0c2c20bdd0d104e93456bf155082a633f3f058e756336::SSHIBA {
    struct SSHIBA has drop {
        dummy_field: bool,
    }

    struct SSHIBAStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SSHIBA>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SSHIBA>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SSHIBA>>(arg0, arg1);
    }

    fun init(arg0: SSHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIBA>(arg0, 9, b"SSHIBA", b"SUI SHIBA", b"SUI SHIBA Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SUIShiba.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SSHIBA>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SSHIBA>>(0x2::coin::from_balance<SSHIBA>(0x2::balance::increase_supply<SSHIBA>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SSHIBAStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SSHIBAStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSHIBA>>(v1);
    }

    public fun total_supply(arg0: &SSHIBAStorage) : u64 {
        0x2::balance::supply_value<SSHIBA>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

