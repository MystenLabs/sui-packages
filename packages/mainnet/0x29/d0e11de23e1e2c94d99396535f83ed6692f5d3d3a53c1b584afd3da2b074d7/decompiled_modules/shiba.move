module 0x29d0e11de23e1e2c94d99396535f83ed6692f5d3d3a53c1b584afd3da2b074d7::shiba {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIBA>, arg1: 0x2::coin::Coin<SHIBA>) {
        0x2::coin::burn<SHIBA>(arg0, arg1);
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBA>(arg0, 6, b"SHIBA SUI", b"SHIBA", b"LETS FLY TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/LbKc56I")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIBA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIBA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

