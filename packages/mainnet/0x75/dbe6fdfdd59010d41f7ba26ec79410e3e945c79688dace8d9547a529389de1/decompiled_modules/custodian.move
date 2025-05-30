module 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::custodian {
    struct Custodian has store, key {
        id: 0x2::object::UID,
        treasury_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        token_balance: 0x2::balance::Balance<0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::pan::PAN>,
        nft_table: 0x2::table::Table<u64, 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::pandorian::Pandorian>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Custodian{
            id               : 0x2::object::new(arg0),
            treasury_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            token_balance    : 0x2::balance::zero<0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::pan::PAN>(),
            nft_table        : 0x2::table::new<u64, 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::pandorian::Pandorian>(arg0),
        };
        0x2::transfer::share_object<Custodian>(v0);
    }

    public(friend) fun add_nft(arg0: &mut Custodian, arg1: 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::pandorian::Pandorian) {
        0x2::table::add<u64, 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::pandorian::Pandorian>(&mut arg0.nft_table, new_nft_slot(arg0), arg1);
    }

    public(friend) fun add_treasury_balance(arg0: &mut Custodian, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_balance, arg1);
    }

    public fun get_nft(arg0: &mut Custodian, arg1: u64) : 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::pandorian::Pandorian {
        0x2::table::remove<u64, 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::pandorian::Pandorian>(&mut arg0.nft_table, arg1)
    }

    fun new_nft_slot(arg0: &Custodian) : u64 {
        0x2::table::length<u64, 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::pandorian::Pandorian>(&arg0.nft_table) + 1
    }

    public(friend) fun withdraw_treasury_balance(arg0: &mut Custodian, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.treasury_balance), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

