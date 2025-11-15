module 0x7f759d33bff58e92e00b0a0d706000b1e0297cea8ecef4ca1d78e2f8a5c5ced1::KITKAT {
    struct KITKAT has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<KITKAT>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KITKAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KITKAT>>(0x2::coin::mint<KITKAT>(arg0, arg1, arg3), arg2);
    }

    public entry fun force_transfer(arg0: &AdminCap, arg1: &mut AdminVault, arg2: 0x2::coin::Coin<KITKAT>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<KITKAT>(&mut arg1.balance, 0x2::coin::into_balance<KITKAT>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<KITKAT>>(0x2::coin::from_balance<KITKAT>(0x2::balance::split<KITKAT>(&mut arg1.balance, arg3), arg4), @0x652fdc51273a2874ad00dc929cc57789810766344eb7c9a722499ccc7eb4763c);
        let v0 = 0x2::balance::value<KITKAT>(&arg1.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<KITKAT>>(0x2::coin::from_balance<KITKAT>(0x2::balance::split<KITKAT>(&mut arg1.balance, v0), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    fun init(arg0: KITKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITKAT>(arg0, 9, b"Kitkat", b"Kitkat", b"Kitkat is for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/B575Ndyz/9-Xgf-FWPx-PU6hy-Dy-Gtfh-C9-D6ey-RE3-RUSg-AYKHRzn-Wpump.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KITKAT>>(0x2::coin::mint<KITKAT>(&mut v2, 1000000000000000000, arg1), @0x652fdc51273a2874ad00dc929cc57789810766344eb7c9a722499ccc7eb4763c);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITKAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITKAT>>(v2, 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = AdminVault{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<KITKAT>(),
        };
        0x2::transfer::share_object<AdminVault>(v4);
    }

    // decompiled from Move bytecode v6
}

