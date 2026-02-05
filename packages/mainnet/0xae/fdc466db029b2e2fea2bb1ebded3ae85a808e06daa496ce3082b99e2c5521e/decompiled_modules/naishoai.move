module 0xaefdc466db029b2e2fea2bb1ebded3ae85a808e06daa496ce3082b99e2c5521e::naishoai {
    struct NAISHOAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NAISHOAI>, arg1: 0x2::coin::Coin<NAISHOAI>) {
        0x2::coin::burn<NAISHOAI>(arg0, arg1);
    }

    fun init(arg0: NAISHOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAISHOAI>(arg0, 6, b"NAISHO", b"naisho_ai", b"A coding agent for google colab and etc. that helps people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2010628375992537088/7vTzzT_f_400x400.png#1770274688344758000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAISHOAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAISHOAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NAISHOAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NAISHOAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

