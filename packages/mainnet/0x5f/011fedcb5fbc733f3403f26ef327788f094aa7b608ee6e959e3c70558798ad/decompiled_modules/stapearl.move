module 0x5f011fedcb5fbc733f3403f26ef327788f094aa7b608ee6e959e3c70558798ad::stapearl {
    struct STAPEARL has drop {
        dummy_field: bool,
    }

    struct SuiPearlVault has key {
        id: 0x2::object::UID,
        treaury_cap: 0x2::coin::TreasuryCap<STAPEARL>,
        position: 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun total_supply(arg0: &SuiPearlVault) : u64 {
        0x2::coin::total_supply<STAPEARL>(&arg0.treaury_cap)
    }

    public fun borrow_position(arg0: &SuiPearlVault) : &0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position {
        &arg0.position
    }

    public fun borrow_position_mut(arg0: &AdminCap, arg1: &mut SuiPearlVault) : &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position {
        &mut arg1.position
    }

    public fun deposit<T0, T1, T2>(arg0: &mut SuiPearlVault, arg1: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg2: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STAPEARL> {
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::increase_position<T0, T1, T2>(arg1, &mut arg0.position, arg2, arg3, arg4);
        0x2::coin::mint<STAPEARL>(&mut arg0.treaury_cap, 0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg2), arg4)
    }

    fun init(arg0: STAPEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAPEARL>(arg0, 6, b"STAPEARL", b"Stable Pearl", b"Fungible token converted from SuiPearl position of stable pair", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STAPEARL>>(v1, v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, v2);
        let v4 = SuiPearlVault{
            id          : 0x2::object::new(arg1),
            treaury_cap : v0,
            position    : 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::new(42, arg1),
        };
        0x2::transfer::share_object<SuiPearlVault>(v4);
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut SuiPearlVault, arg1: &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg2: 0x2::coin::Coin<STAPEARL>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        0x2::coin::burn<STAPEARL>(&mut arg0.treaury_cap, arg2);
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::operator::decrease_position_<T0, T1, T2>(arg1, &mut arg0.position, 0x2::coin::value<STAPEARL>(&arg2), arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

