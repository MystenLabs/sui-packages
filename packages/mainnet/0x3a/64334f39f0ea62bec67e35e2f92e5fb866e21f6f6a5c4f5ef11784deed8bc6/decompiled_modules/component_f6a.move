module 0x3a64334f39f0ea62bec67e35e2f92e5fb866e21f6f6a5c4f5ef11784deed8bc6::component_f6a {
    struct COMPONENT_F6A has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<COMPONENT_F6A>, arg1: 0x2::coin::Coin<COMPONENT_F6A>) {
        0x2::coin::burn<COMPONENT_F6A>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<COMPONENT_F6A>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COMPONENT_F6A> {
        0x2::coin::mint<COMPONENT_F6A>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<COMPONENT_F6A>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COMPONENT_F6A>>(0x2::coin::mint<COMPONENT_F6A>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COMPONENT_F6A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMPONENT_F6A>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<COMPONENT_F6A>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMPONENT_F6A>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

