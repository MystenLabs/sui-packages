module 0x455fdab0edb9c87e465d5dde681a0652335e8837416bea663787b5a4b8be262a::safu {
    struct SAFU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SAFU>, arg1: 0x2::coin::Coin<SAFU>) {
        0x2::coin::burn<SAFU>(arg0, arg1);
    }

    fun init(arg0: SAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFU>(arg0, 6, b"SAFU COIN", b"SAFU", b"total supply will be 100% locked for 1 year #SAFUTRADINGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/0FNDb3s/safu.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAFU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SAFU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

