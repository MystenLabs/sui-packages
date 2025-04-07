module 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    struct CSUITreasuryCoinfig has store, key {
        id: 0x2::object::UID,
        treasuryCap: 0x2::coin::TreasuryCap<CSUI>,
    }

    public(friend) fun burn_csui(arg0: &mut CSUITreasuryCoinfig, arg1: 0x2::coin::Coin<CSUI>) {
        0x2::coin::burn<CSUI>(&mut arg0.treasuryCap, arg1);
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSUI>(arg0, 9, b"cSUI", b"cSUI", b"cSUI is a staking token of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cro-ag.pages.dev/csui.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSUI>>(v1);
        let v2 = CSUITreasuryCoinfig{
            id          : 0x2::object::new(arg1),
            treasuryCap : v0,
        };
        0x2::transfer::public_share_object<CSUITreasuryCoinfig>(v2);
    }

    public(friend) fun mint_csui(arg0: &mut CSUITreasuryCoinfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CSUI> {
        0x2::coin::mint<CSUI>(&mut arg0.treasuryCap, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

