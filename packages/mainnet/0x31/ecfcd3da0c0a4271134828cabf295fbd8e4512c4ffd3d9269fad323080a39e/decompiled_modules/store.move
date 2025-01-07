module 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::store {
    struct STORE has drop {
        dummy_field: bool,
    }

    struct StoreHub has key {
        id: 0x2::object::UID,
        suimo_minted: u64,
        suimo_supply: u64,
        suimo_price: u64,
        item_price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SuimoMinted has copy, drop {
        suimo_id: 0x2::object::ID,
        minter: address,
    }

    struct SuimoItemMinted has copy, drop {
        item_id: 0x2::object::ID,
        rarity: 0x1::string::String,
        minter: address,
    }

    public fun balance(arg0: &StoreHub) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun handle_open_item(arg0: &mut 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::ItemHub, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 2;
        while (v0 < 3) {
            open_item(arg0, arg1);
            v0 = v0 + 1;
        };
    }

    fun handle_payment(arg0: &mut StoreHub, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 0);
        replenish_balance(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg3));
        0x2::pay::keep<0x2::sui::SUI>(arg1, arg3);
    }

    fun init(arg0: STORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STORE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = StoreHub{
            id           : 0x2::object::new(arg1),
            suimo_minted : 0,
            suimo_supply : 100000,
            suimo_price  : 10000000,
            item_price   : 10000000,
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<StoreHub>(v0);
    }

    public entry fun mint_item(arg0: &mut StoreHub, arg1: &mut 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::ItemHub, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.item_price;
        handle_payment(arg0, arg2, v0, arg3);
        handle_open_item(arg1, arg3);
    }

    public entry fun mint_suimo(arg0: &mut StoreHub, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.suimo_minted + 1;
        assert!(v0 <= arg0.suimo_supply, 2);
        arg0.suimo_minted = v0;
        let v1 = arg0.suimo_price;
        handle_payment(arg0, arg1, v1, arg2);
        let v2 = 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::suimo::create(v0, arg2);
        let v3 = SuimoMinted{
            suimo_id : 0x2::object::id<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::suimo::Suimo>(&v2),
            minter   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SuimoMinted>(v3);
        0x2::transfer::public_transfer<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::suimo::Suimo>(v2, 0x2::tx_context::sender(arg2));
    }

    fun open_item(arg0: &mut 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::ItemHub, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::create(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun replenish_balance(arg0: &mut StoreHub, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun suimo_price(arg0: &StoreHub) : u64 {
        arg0.suimo_price
    }

    public entry fun update_item_price(arg0: &0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::AdminCap, arg1: &mut StoreHub, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.item_price = arg2;
    }

    public entry fun update_item_supply(arg0: &0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::AdminCap, arg1: &mut StoreHub, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.suimo_supply = arg2;
    }

    public entry fun update_suimo_price(arg0: &0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::AdminCap, arg1: &mut StoreHub, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.suimo_price = arg2;
    }

    public entry fun withdraw(arg0: &0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::AdminCap, arg1: &mut StoreHub, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 1);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

