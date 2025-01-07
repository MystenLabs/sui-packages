module 0x7cd6bea7c6dd52beeb48ab683f8b0a36b4e14f0ed0be8fc7c929b46fbb604c1b::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    public entry fun decrease_supply(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: vector<0x2::coin::Coin<USDT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::decrease_supply<USDT>(0x2::coin::supply_mut<USDT>(arg0), 0x2::coin::into_balance<USDT>(0xea2ef08c61bcfa88f22442782e2769acfcd73f506d1fd96664def94f390b54a2::payment::take_from<USDT>(arg1, arg2, arg3)));
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: vector<0x2::coin::Coin<USDT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<USDT>(arg0, 0xea2ef08c61bcfa88f22442782e2769acfcd73f506d1fd96664def94f390b54a2::payment::take_from<USDT>(arg1, arg2, arg3));
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 9, b"USDT", b"USDT", b"USDT test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://seapad.s3.ap-southeast-1.amazonaws.com/uploads/TEST/public/media/images/logo_1679906850804.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDT>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

