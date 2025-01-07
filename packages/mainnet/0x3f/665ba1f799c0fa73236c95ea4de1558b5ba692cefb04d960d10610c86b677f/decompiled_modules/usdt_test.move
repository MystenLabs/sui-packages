module 0x3f665ba1f799c0fa73236c95ea4de1558b5ba692cefb04d960d10610c86b677f::usdt_test {
    struct USDT_TEST has drop {
        dummy_field: bool,
    }

    public entry fun decrease_supply(arg0: &mut 0x2::coin::TreasuryCap<USDT_TEST>, arg1: vector<0x2::coin::Coin<USDT_TEST>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::decrease_supply<USDT_TEST>(0x2::coin::supply_mut<USDT_TEST>(arg0), 0x2::coin::into_balance<USDT_TEST>(0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<USDT_TEST>(arg1, arg2, arg3)));
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDT_TEST>, arg1: vector<0x2::coin::Coin<USDT_TEST>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<USDT_TEST>(arg0, 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<USDT_TEST>(arg1, arg2, arg3));
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<USDT_TEST>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: USDT_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT_TEST>(arg0, 9, b"USDT", b"USDT", b"USDT test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://seapad.s3.ap-southeast-1.amazonaws.com/uploads/TEST/public/media/images/logo_1679906850804.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT_TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<USDT_TEST>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDT_TEST>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

