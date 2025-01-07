module 0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::xsake {
    struct XSAKE has drop {
        dummy_field: bool,
    }

    struct XSakeStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<XSAKE>,
        sake_coins: 0x2::balance::Balance<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>>(arg0, arg1);
    }

    public fun burn(arg0: &mut XSakeStorage, arg1: 0x2::coin::Coin<XSAKE>) : u64 {
        0x2::balance::decrease_supply<XSAKE>(&mut arg0.supply, 0x2::coin::into_balance<XSAKE>(arg1))
    }

    public entry fun convert_from_sake(arg0: &mut XSakeStorage, arg1: 0x2::coin::Coin<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg2, arg3);
        let v1 = 0x2::coin::split<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>(&mut arg1, arg2, arg3);
        return_remaining_coin<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>(arg1, arg3);
        0x2::balance::join<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>(&mut arg0.sake_coins, 0x2::coin::into_balance<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>(v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<XSAKE>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun convert_to_sake(arg0: &mut XSakeStorage, arg1: 0x2::coin::Coin<XSAKE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        burn(arg0, 0x2::coin::split<XSAKE>(&mut arg1, arg2, arg3));
        return_remaining_coin<XSAKE>(arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>>(0x2::coin::from_balance<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>(0x2::balance::split<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>(&mut arg0.sake_coins, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: XSAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSAKE>(arg0, 9, b"XSAKE", b"Kojiki Protocol Escrowed Coin", b"The Escrowed Coin of Kojiki Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://brown-democratic-crawdad-536.mypinata.cloud/ipfs/QmZmqPtULkUvzkCEnkYdGwGiRFnKEbJq3RhxSoCTsmX5Ed")), arg1);
        let v2 = XSakeStorage{
            id         : 0x2::object::new(arg1),
            supply     : 0x2::coin::treasury_into_supply<XSAKE>(v0),
            sake_coins : 0x2::balance::zero<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>(),
        };
        0x2::transfer::share_object<XSakeStorage>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSAKE>>(v1);
    }

    public fun mint(arg0: &mut XSakeStorage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<XSAKE> {
        0x2::coin::from_balance<XSAKE>(0x2::balance::increase_supply<XSAKE>(&mut arg0.supply, arg1), arg2)
    }

    fun return_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun total_supply(arg0: &XSakeStorage) : u64 {
        0x2::balance::supply_value<XSAKE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

