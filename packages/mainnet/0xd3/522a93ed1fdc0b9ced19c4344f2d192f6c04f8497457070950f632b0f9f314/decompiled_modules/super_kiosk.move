module 0xd3522a93ed1fdc0b9ced19c4344f2d192f6c04f8497457070950f632b0f9f314::super_kiosk {
    struct SuperKiosk has store, key {
        id: 0x2::object::UID,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    public fun borrow_kiosk(arg0: &mut SuperKiosk) : &mut 0x2::kiosk::Kiosk {
        &mut arg0.kiosk
    }

    public fun borrow_kiosk_cap(arg0: &mut SuperKiosk) : &0x2::kiosk::KioskOwnerCap {
        &arg0.kiosk_cap
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = SuperKiosk{
            id        : 0x2::object::new(arg0),
            kiosk     : v0,
            kiosk_cap : v1,
        };
        0x2::transfer::share_object<SuperKiosk>(v2);
    }

    public fun mint_poetry_booster_pack(arg0: &mut SuperKiosk, arg1: &mut 0x9c97500fd49fd0f13b753bed6fd0352eb199c1bb026d3340d25c7ace8bb8b5fc::words2words::WordsData, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9c97500fd49fd0f13b753bed6fd0352eb199c1bb026d3340d25c7ace8bb8b5fc::words2words::mintBoosterPack(arg2, &mut arg0.kiosk, &arg0.kiosk_cap, arg1, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

