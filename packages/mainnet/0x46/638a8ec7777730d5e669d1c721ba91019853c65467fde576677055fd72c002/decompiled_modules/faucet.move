module 0x46638a8ec7777730d5e669d1c721ba91019853c65467fde576677055fd72c002::faucet {
    struct Pool has store, key {
        id: 0x2::object::UID,
        ssui_vault: 0x2::balance::Balance<0xad3130d374870fdbe4ed3ead4e05ee713a5905eb5734cd2b4db29937880a68c8::ssui::SSUI>,
    }

    public entry fun add_ssui(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xad3130d374870fdbe4ed3ead4e05ee713a5905eb5734cd2b4db29937880a68c8::ssui::SSUI>) {
        0x2::balance::join<0xad3130d374870fdbe4ed3ead4e05ee713a5905eb5734cd2b4db29937880a68c8::ssui::SSUI>(&mut arg0.ssui_vault, 0x2::coin::into_balance<0xad3130d374870fdbe4ed3ead4e05ee713a5905eb5734cd2b4db29937880a68c8::ssui::SSUI>(arg1));
    }

    public entry fun faucet_ssui(arg0: &mut Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xad3130d374870fdbe4ed3ead4e05ee713a5905eb5734cd2b4db29937880a68c8::ssui::SSUI>>(0x2::coin::take<0xad3130d374870fdbe4ed3ead4e05ee713a5905eb5734cd2b4db29937880a68c8::ssui::SSUI>(&mut arg0.ssui_vault, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id         : 0x2::object::new(arg0),
            ssui_vault : 0x2::balance::zero<0xad3130d374870fdbe4ed3ead4e05ee713a5905eb5734cd2b4db29937880a68c8::ssui::SSUI>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    // decompiled from Move bytecode v6
}

