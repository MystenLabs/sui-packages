module 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::custodian {
    struct Custodian has store, key {
        id: 0x2::object::UID,
        treasury_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        nft_table_by_id: 0x2::table::Table<0x2::object::ID, 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>,
        nft_table_by_address: 0x2::table::Table<address, vector<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Custodian{
            id                   : 0x2::object::new(arg0),
            treasury_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            nft_table_by_id      : 0x2::table::new<0x2::object::ID, 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>(arg0),
            nft_table_by_address : 0x2::table::new<address, vector<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>>(arg0),
        };
        0x2::transfer::share_object<Custodian>(v0);
    }

    public(friend) fun add_nft_by_address(arg0: &mut Custodian, arg1: address, arg2: 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian) {
        if (0x2::table::contains<address, vector<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>>(&arg0.nft_table_by_address, arg1)) {
            0x1::vector::push_back<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>(0x2::table::borrow_mut<address, vector<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>>(&mut arg0.nft_table_by_address, arg1), arg2);
        } else {
            let v0 = 0x1::vector::empty<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>();
            0x1::vector::push_back<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>(&mut v0, arg2);
            0x2::table::add<address, vector<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>>(&mut arg0.nft_table_by_address, arg1, v0);
        };
    }

    public(friend) fun add_nft_by_id(arg0: &mut Custodian, arg1: 0x2::object::ID, arg2: 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian) {
        0x2::table::add<0x2::object::ID, 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>(&mut arg0.nft_table_by_id, arg1, arg2);
    }

    public(friend) fun add_treasury_balance(arg0: &mut Custodian, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_balance, arg1);
    }

    public(friend) fun get_nft_by_address(arg0: &mut Custodian, arg1: address, arg2: u64) : vector<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian> {
        let v0 = 0x2::table::borrow_mut<address, vector<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>>(&mut arg0.nft_table_by_address, arg1);
        assert!(arg2 > 0 && arg2 <= 0x1::vector::length<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>(v0), 200);
        let v1 = 0x1::vector::empty<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>();
        let v2 = 0;
        while (v2 < arg2) {
            0x1::vector::push_back<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>(&mut v1, 0x1::vector::pop_back<0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>(v0));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun get_nft_by_id(arg0: &mut Custodian, arg1: 0x2::object::ID) : 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian {
        0x2::table::remove<0x2::object::ID, 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::pandorian::Pandorian>(&mut arg0.nft_table_by_id, arg1)
    }

    public(friend) fun withdraw_treasury_balance(arg0: &mut Custodian, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.treasury_balance), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

