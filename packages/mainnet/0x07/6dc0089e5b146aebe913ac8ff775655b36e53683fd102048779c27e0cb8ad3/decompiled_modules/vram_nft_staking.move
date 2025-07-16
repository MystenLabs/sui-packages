module 0x76dc0089e5b146aebe913ac8ff775655b36e53683fd102048779c27e0cb8ad3::vram_nft_staking {
    struct Treasury has key {
        id: 0x2::object::UID,
        status: bool,
    }

    struct VRAM_NFT_STAKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRAM_NFT_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id     : 0x2::object::new(arg1),
            status : true,
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun unstake<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::return_purchase_cap<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

