module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token {
    struct MintDiveTokenEvent has copy, drop {
        amount: u64,
        recipient: address,
        mint_type: u8,
    }

    struct BurnDiveTokenEvent has copy, drop {
        amount: u64,
        burn_type: u8,
    }

    struct DIVE_TOKEN has drop {
        dummy_field: bool,
    }

    struct DIVETokenTreasuryCap has key {
        id: 0x2::object::UID,
        dive_token_treasury: 0x2::coin::TreasuryCap<DIVE_TOKEN>,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DIVE_TOKEN>, arg2: address, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg3, arg4);
        0x2::coin::deny_list_v2_add<DIVE_TOKEN>(arg0, arg1, arg2, arg5);
    }

    public(friend) fun burn_dive_token(arg0: &mut DIVETokenTreasuryCap, arg1: 0x2::coin::Coin<DIVE_TOKEN>, arg2: u8) {
        0x2::coin::burn<DIVE_TOKEN>(&mut arg0.dive_token_treasury, arg1);
        let v0 = BurnDiveTokenEvent{
            amount    : 0x2::coin::value<DIVE_TOKEN>(&arg1),
            burn_type : arg2,
        };
        0x2::event::emit<BurnDiveTokenEvent>(v0);
    }

    fun init(arg0: DIVE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DIVE_TOKEN>(arg0, 6, b"DIVE", b"DiverS Token", b"The essential in-game currency for DiverS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAwCAYAAABqkJjhAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAENSURBVHgB7ZlBDoJADEUH41LXXoZLufMI7LwUl3GNeyXRaKbDpLS0JO30bQiBQPPnZdJ0ukTkNZME6WYo7x+SMY6Jy4MUTMmFt1D+EpZ2Fvs+5rS5hFERfwlsdRbj67S7hAuHuc6O91N231+fiQPmtKNdQttZ7H+VfdreLlF1FkkYOotBdtpLwn+H93YWo+J0Q90aAHNUap82l3AUrE0UrE0UrE0UrE0UrI1YL4H1x9zeAWI3YaluSoqinuFzbcdhuAJ7rZDdhPthyh6Mt3N2r+106ey0+J69hOHsijtb01oB87O1YhhRS1ja6bXO+pteSjnNpeEzDgB0mspaZyH+egltp92fNZOHwpEwkTeDMmoGKUYjAgAAAABJRU5ErkJggg=="))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIVE_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DIVE_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = DIVETokenTreasuryCap{
            id                  : 0x2::object::new(arg1),
            dive_token_treasury : v0,
        };
        0x2::transfer::share_object<DIVETokenTreasuryCap>(v3);
    }

    public(friend) fun mint_dive_token(arg0: &mut DIVETokenTreasuryCap, arg1: u64, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DIVE_TOKEN>(&mut arg0.dive_token_treasury, arg1, arg2, arg4);
        let v0 = MintDiveTokenEvent{
            amount    : arg1,
            recipient : arg2,
            mint_type : arg3,
        };
        0x2::event::emit<MintDiveTokenEvent>(v0);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DIVE_TOKEN>, arg2: address, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg3, arg4);
        0x2::coin::deny_list_v2_remove<DIVE_TOKEN>(arg0, arg1, arg2, arg5);
    }

    // decompiled from Move bytecode v6
}

