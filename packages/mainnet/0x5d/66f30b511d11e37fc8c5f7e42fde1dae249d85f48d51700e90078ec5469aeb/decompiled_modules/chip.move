module 0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip {
    struct CHIP has drop {
        dummy_field: bool,
    }

    struct ChipTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<CHIP>,
    }

    public fun total_supply(arg0: &ChipTreasury) : u64 {
        0x2::coin::total_supply<CHIP>(&arg0.cap)
    }

    public(friend) fun burn(arg0: &mut ChipTreasury, arg1: 0x2::balance::Balance<CHIP>) {
        0x2::balance::decrease_supply<CHIP>(0x2::coin::supply_mut<CHIP>(&mut arg0.cap), arg1);
    }

    fun init(arg0: CHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHIP>(arg0, 0, 0x1::string::utf8(b"CHIP"), 0x1::string::utf8(b"DOPA-OPEN tournament chip"), 0x1::string::utf8(b"Closed-loop chips for DOPA-OPEN open-entry tournaments. No value outside a tournament."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHIP>>(0x2::coin_registry::finalize<CHIP>(v0, arg1), 0x2::tx_context::sender(arg1));
        let v2 = ChipTreasury{
            id  : 0x2::object::new(arg1),
            cap : v1,
        };
        0x2::transfer::share_object<ChipTreasury>(v2);
    }

    public(friend) fun mint(arg0: &mut ChipTreasury, arg1: u64) : 0x2::balance::Balance<CHIP> {
        0x2::coin::mint_balance<CHIP>(&mut arg0.cap, arg1)
    }

    // decompiled from Move bytecode v7
}

