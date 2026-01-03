module 0x74bef6b489619f735a7950106bf9d70845d79d75b17dc00d3a348826d1ef0255::SSUI {
    struct SSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SSUI>, arg1: 0x2::coin::Coin<SSUI>) {
        0x2::coin::burn<SSUI>(arg0, arg1);
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 9, b"SUI", b"Sui", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/sui_c07df05f00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

