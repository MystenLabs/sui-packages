module 0x43134f2d5e1323c51fe7450d59d96900b231728feb7d5f3482919e7b450aa455::sxr {
    struct SXR has drop {
        dummy_field: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        sxr_balance: 0x2::balance::Balance<SXR>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun deposit_sxr(arg0: &OwnerCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<SXR>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<SXR>(&mut arg1.sxr_balance, 0x2::coin::into_balance<SXR>(arg2));
    }

    fun init(arg0: SXR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Vault{
            id          : 0x2::object::new(arg1),
            sxr_balance : 0x2::balance::zero<SXR>(),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Vault>(v1);
        let (v2, v3) = 0x2::coin::create_currency<SXR>(arg0, 9, b"SXR", b"Suixer DAO Token", b"Utility token of the Suixer NFT marketplace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://QmXJi4XhbgkMJC4qCwShenCUXLABVCSseBqeummqQP1mWJ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SXR>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXR>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun trade(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<SXR>>(0x2::coin::from_balance<SXR>(0x2::balance::split<SXR>(&mut arg1.sxr_balance, 0x2::coin::value<0x2::sui::SUI>(&arg0) * 100), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawal_sui(arg0: &OwnerCap, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawal_sxr(arg0: &OwnerCap, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SXR>>(0x2::coin::from_balance<SXR>(0x2::balance::split<SXR>(&mut arg1.sxr_balance, 0x2::balance::value<SXR>(&arg1.sxr_balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

