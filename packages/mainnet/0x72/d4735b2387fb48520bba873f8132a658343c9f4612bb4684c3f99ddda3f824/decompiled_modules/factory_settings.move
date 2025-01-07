module 0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::factory_settings {
    struct FactorySetings has key {
        id: 0x2::object::UID,
        mint_fee: u64,
        treasury: address,
    }

    struct FactorySettingsOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_mint_fee(arg0: &FactorySetings) : u64 {
        arg0.mint_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FactorySettingsOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FactorySettingsOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FactorySetings{
            id       : 0x2::object::new(arg0),
            mint_fee : 0,
            treasury : @0xfb9d4d41b2214a5f370e5f899359040b0b2afe534e9e8eed35c9e0d1fecd45e1,
        };
        0x2::transfer::share_object<FactorySetings>(v1);
    }

    public(friend) fun send_fees(arg0: &FactorySetings, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
    }

    public entry fun update_mint_fee(arg0: &FactorySettingsOwnerCap, arg1: &mut FactorySetings, arg2: u64) {
        arg1.mint_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

