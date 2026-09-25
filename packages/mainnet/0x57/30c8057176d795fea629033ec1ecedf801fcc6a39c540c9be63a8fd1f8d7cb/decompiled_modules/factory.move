module 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::factory {
    struct LaunchTicket<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
    }

    public(friend) fun consume<T0>(arg0: LaunchTicket<T0>) : 0x2::coin::TreasuryCap<T0> {
        let LaunchTicket {
            id       : v0,
            treasury : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public(friend) fun create<T0: drop>(arg0: T0, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::coin_registry::finalize_and_delete_metadata_cap<T0>(v0, arg6);
        let v2 = LaunchTicket<T0>{
            id       : 0x2::object::new(arg6),
            treasury : v1,
        };
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::events::token_created<T0>(0x2::object::id<LaunchTicket<T0>>(&v2), 0x2::object::id<0x2::coin::TreasuryCap<T0>>(&v2.treasury), arg1, arg6);
        0x2::transfer::transfer<LaunchTicket<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

