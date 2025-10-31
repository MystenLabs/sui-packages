module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token {
    struct MintPearlTokenEvent has copy, drop {
        amount: u64,
        recipient: address,
        mint_type: u8,
    }

    struct BurnPearlTokenEvent has copy, drop {
        amount: u64,
        burn_type: u8,
    }

    struct PEARL_TOKEN has key {
        id: 0x2::object::UID,
    }

    struct PearlTokenTreasuryCap has key {
        id: 0x2::object::UID,
        pearl_token_treasury: 0x2::coin::TreasuryCap<PEARL_TOKEN>,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEARL_TOKEN>, arg2: address, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg3, arg4);
        0x2::coin::deny_list_v2_add<PEARL_TOKEN>(arg0, arg1, arg2, arg5);
    }

    public fun admin_init_pearl_token(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg1);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg1, arg2);
        let (v0, v1) = 0x2::coin_registry::new_currency<PEARL_TOKEN>(arg0, 6, 0x1::string::utf8(b"PEARL"), 0x1::string::utf8(b"Pearl"), 0x1::string::utf8(b"$PEARL is tradable token in DiverS"), 0x1::string::utf8(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAwCAYAAABqkJjhAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAEhSURBVHgB7ZmxEcIwDAAdLi1bULJAKo4RGIKeUegZghE4KhagZAsGgKQwF2R8smwrRo6+Su58OUX52LLcGCKvHpORpocyfmGE0ZpIno+rSWG52pgY6stwbmex52NOi8sw+ofaDKQ6i2Gdri7DjsPczmJgTst3eCpnMXxOkxYO6mTP8dJtaWcxYHxyZ4nYz3c7HUjj19td0DgYj9VRXIY1YG6i62Ef3f74uf71X9wv56/7UKctqgQ36jA2L1OdhZACLl0QDajD3GR3ONVRDFWCG7kOp67xuYHxdFoPT4S8voRv1wxrAm6nHWdHdfUYebME7Kz8W5+i3t4aJLfToc6Kz7BTrZV2er5nHBBqTw0S6iykvh0Ht9PVnzWT3m5AM0zkDT28dggSulksAAAAAElFTkSuQmCC"), arg3);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PEARL_TOKEN>>(0x2::coin_registry::finalize<PEARL_TOKEN>(v2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEARL_TOKEN>>(0x2::coin_registry::make_regulated<PEARL_TOKEN>(&mut v2, true, arg3), 0x2::tx_context::sender(arg3));
        let v3 = PearlTokenTreasuryCap{
            id                   : 0x2::object::new(arg3),
            pearl_token_treasury : v1,
        };
        0x2::transfer::share_object<PearlTokenTreasuryCap>(v3);
    }

    entry fun admin_mint_liquidity_token(arg0: &mut PearlTokenTreasuryCap, arg1: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg2: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg1);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg1, arg2);
        0x2::coin::mint_and_transfer<PEARL_TOKEN>(&mut arg0.pearl_token_treasury, arg3, 0x2::tx_context::sender(arg4), arg4);
    }

    public(friend) fun burn_pearl_token(arg0: &mut PearlTokenTreasuryCap, arg1: 0x2::coin::Coin<PEARL_TOKEN>, arg2: u8) {
        0x2::coin::burn<PEARL_TOKEN>(&mut arg0.pearl_token_treasury, arg1);
        let v0 = BurnPearlTokenEvent{
            amount    : 0x2::coin::value<PEARL_TOKEN>(&arg1),
            burn_type : arg2,
        };
        0x2::event::emit<BurnPearlTokenEvent>(v0);
    }

    public(friend) fun mint_pearl_token(arg0: &mut PearlTokenTreasuryCap, arg1: u64, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEARL_TOKEN>(&mut arg0.pearl_token_treasury, arg1, arg2, arg4);
        let v0 = MintPearlTokenEvent{
            amount    : arg1,
            recipient : arg2,
            mint_type : arg3,
        };
        0x2::event::emit<MintPearlTokenEvent>(v0);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEARL_TOKEN>, arg2: address, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg3, arg4);
        0x2::coin::deny_list_v2_remove<PEARL_TOKEN>(arg0, arg1, arg2, arg5);
    }

    // decompiled from Move bytecode v6
}

