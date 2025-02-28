module 0x96f05edf1e2cc701f9e6468aa39c831bcfa71ca4a8fc46407369533d71154705::profile_card {
    struct ProfileCard has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        index: u64,
    }

    struct GlobalStateObject has store, key {
        id: 0x2::object::UID,
        index: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun create_profile_card(arg0: &mut GlobalStateObject, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : ProfileCard {
        arg0.index = arg0.index + 1;
        let v0 = ProfileCard{
            id    : 0x2::object::new(arg4),
            name  : arg1,
            url   : arg2,
            index : arg0.index,
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalStateObject{
            id      : 0x2::object::new(arg0),
            index   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::public_share_object<GlobalStateObject>(v0);
    }

    // decompiled from Move bytecode v6
}

