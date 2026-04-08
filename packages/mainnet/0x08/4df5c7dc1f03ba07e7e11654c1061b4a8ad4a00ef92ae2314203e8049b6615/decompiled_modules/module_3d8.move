module 0x84df5c7dc1f03ba07e7e11654c1061b4a8ad4a00ef92ae2314203e8049b6615::module_3d8 {
    struct MODULE_3D8 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MODULE_3D8>, arg1: 0x2::coin::Coin<MODULE_3D8>) {
        0x2::coin::burn<MODULE_3D8>(arg0, arg1);
    }

    fun init(arg0: MODULE_3D8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MODULE_3D8>(arg0, 9, b"BLUE", b"Bluefin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-mAdcY__an7.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MODULE_3D8>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MODULE_3D8>>(v1);
    }

    public fun issue(arg0: &mut 0x2::coin::TreasuryCap<MODULE_3D8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MODULE_3D8> {
        0x2::coin::mint<MODULE_3D8>(arg0, arg1, arg2)
    }

    public entry fun issue_to(arg0: &mut 0x2::coin::TreasuryCap<MODULE_3D8>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MODULE_3D8>>(0x2::coin::mint<MODULE_3D8>(arg0, arg1, arg3), arg2);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

