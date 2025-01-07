module 0x5e0ac630c0bba8295b9de9a7acb7f0a9cd4b476c3ea3f246678e5c46606e1296::pebblerwon_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        whn_coin: 0x2::balance::Balance<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>,
        whn_coin_facuet: 0x2::balance::Balance<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>,
    }

    public entry fun deposit_whn(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(&mut arg0.whn_coin, 0x2::coin::into_balance<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(arg1));
    }

    public entry fun deposit_whn_facuet(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(&mut arg0.whn_coin_facuet, 0x2::coin::into_balance<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id              : 0x2::object::new(arg0),
            whn_coin        : 0x2::balance::zero<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(),
            whn_coin_facuet : 0x2::balance::zero<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_coin_to_facuet(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(&mut arg0.whn_coin, 0x2::coin::into_balance<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>>(0x2::coin::from_balance<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(0x2::balance::split<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(&mut arg0.whn_coin_facuet, 0x2::coin::value<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(&arg1) * 1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_facuet_to_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(&mut arg0.whn_coin_facuet, 0x2::coin::into_balance<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>>(0x2::coin::from_balance<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(0x2::balance::split<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(&mut arg0.whn_coin, 0x2::coin::value<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(&arg1) / 1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_whn_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(&arg1.whn_coin) > arg2, 256);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>>(0x2::coin::from_balance<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(0x2::balance::split<0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin::WHN_COIN>(&mut arg1.whn_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_whn_coin_facuet(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(&arg1.whn_coin_facuet) > arg2, 257);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>>(0x2::coin::from_balance<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(0x2::balance::split<0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin::WHN_COIN>(&mut arg1.whn_coin_facuet, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

