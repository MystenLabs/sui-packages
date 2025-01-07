module 0x817d9dbd7ca711897e5cea739c83feb8eb5b8ce71e8040ddc8abcb7e6d91579e::simple_token {
    struct SIMPLE_TOKEN has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"PRESIDENT", b"Trump President", b"Official token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SIMPLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SIMPLE_TOKEN>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIMPLE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIMPLE_TOKEN>(arg0, arg1, arg2, arg3);
    }

    public entry fun publish_token_info(arg0: &0x2::coin::TreasuryCap<SIMPLE_TOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun update_price_and_volume(arg0: &0x2::coin::TreasuryCap<SIMPLE_TOKEN>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

