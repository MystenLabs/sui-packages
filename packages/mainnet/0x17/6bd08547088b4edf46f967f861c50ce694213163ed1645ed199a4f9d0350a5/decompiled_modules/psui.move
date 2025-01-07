module 0x176bd08547088b4edf46f967f861c50ce694213163ed1645ed199a4f9d0350a5::psui {
    struct PSUI has drop {
        dummy_field: bool,
    }

    struct PSUICONTROLLER<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    public(friend) fun burn(arg0: &mut PSUICONTROLLER<PSUI>, arg1: 0x2::coin::Coin<PSUI>) {
        0x2::coin::burn<PSUI>(&mut arg0.treasury_cap, arg1);
    }

    public fun total_supply(arg0: &PSUICONTROLLER<PSUI>) : u64 {
        0x2::coin::total_supply<PSUI>(&arg0.treasury_cap)
    }

    fun init(arg0: PSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUI>(arg0, 9, b"pSui", b"pSui", b"pSui Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = PSUICONTROLLER<PSUI>{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<PSUICONTROLLER<PSUI>>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUI>>(v1);
    }

    public(friend) fun mint(arg0: &mut PSUICONTROLLER<PSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PSUI>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

