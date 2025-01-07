module 0xf959edfa53336e4ac340d7dbeaffc50e36d644bd425868e482cff74a1777002d::exp {
    struct EXP has drop {
        dummy_field: bool,
    }

    struct ExpGlobal has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    public(friend) fun burn(arg0: &mut 0x2::coin::TreasuryCap<EXP>, arg1: 0x2::coin::Coin<EXP>) {
        0x2::coin::burn<EXP>(arg0, arg1);
    }

    public entry fun change_global(arg0: &mut ExpGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
    }

    public entry fun friend_burn(arg0: &mut ExpGlobal, arg1: &mut 0x2::coin::TreasuryCap<EXP>, arg2: 0x2::coin::Coin<EXP>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        0x2::coin::burn<EXP>(arg1, arg2);
    }

    public entry fun friend_mint(arg0: &mut ExpGlobal, arg1: &mut 0x2::coin::TreasuryCap<EXP>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        0x2::coin::mint_and_transfer<EXP>(arg1, arg2, arg3, arg4);
    }

    fun init(arg0: EXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXP>(arg0, 9, b"SEXP", b"PEPE WolfGame SEXP", b"PEPE WolfGame SEXP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pepewolfgame.vip/sheep.svg"))), arg1);
        let v2 = ExpGlobal{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXP>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<EXP>>(v0);
        0x2::transfer::share_object<ExpGlobal>(v2);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<EXP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EXP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

