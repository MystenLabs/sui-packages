module 0xdff8dabe5e591fd37ccd8b414dc4355083ffdb1c631911018058cee1163c8044::agent {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 9, b"IHG", b"ihg", b"IHGIHGIHG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dapp.suiagents.ai/assets/images/nft-images/agent.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint<T0>(arg0: &mut AdminCap, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

