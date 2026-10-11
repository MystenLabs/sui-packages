module 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays {
    struct PLAYS has drop {
        dummy_field: bool,
    }

    struct LaunchCap has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Balance<PLAYS>,
    }

    public(friend) fun consume_launch_cap(arg0: LaunchCap) : 0x2::balance::Balance<PLAYS> {
        let LaunchCap {
            id     : v0,
            supply : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    fun create(arg0: PLAYS, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<PLAYS>, 0x2::balance::Balance<PLAYS>) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PLAYS>(arg0, 9, 0x1::string::utf8(b"PLAYs"), 0x1::string::utf8(b"PLAYs"), 0x1::string::utf8(b"PLAYs: fixed-initial-supply token for SuiPlay SBT holders. 1,000,000,000 initial supply, no minting, unclaimed airdrop burned after 30 days. Not affiliated with Sui, Mysten Labs, or Playtron."), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeibsibytrbnnmupkfaxjgd4njqundygfh4kxh7penfe4xhvekzyntu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PLAYS>(&mut v3, v2);
        (v3, 0x2::coin::mint_balance<PLAYS>(&mut v2, 1000000000000000000))
    }

    public fun decimals_constant() : u8 {
        9
    }

    fun init(arg0: PLAYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PLAYS>>(0x2::coin_registry::finalize<PLAYS>(v0, arg1), 0x2::tx_context::sender(arg1));
        let v2 = LaunchCap{
            id     : 0x2::object::new(arg1),
            supply : v1,
        };
        0x2::transfer::transfer<LaunchCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun launch_cap_value(arg0: &LaunchCap) : u64 {
        0x2::balance::value<PLAYS>(&arg0.supply)
    }

    public fun total_supply_constant() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v7
}

