module 0xd2c61ec9407f46136af4aef5db40aff79d27e82d5bfe9d92fa3377c4cb63e0b::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    public fun create(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<REGISTRY> {
        0x2::coin::mint<REGISTRY>(arg0, arg1, arg2)
    }

    public entry fun create_to(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REGISTRY>>(0x2::coin::mint<REGISTRY>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY>, arg1: 0x2::coin::Coin<REGISTRY>) {
        0x2::coin::burn<REGISTRY>(arg0, arg1);
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGISTRY>(arg0, 9, b"NS", b"SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-GRKPYMiR86.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<REGISTRY>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGISTRY>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

