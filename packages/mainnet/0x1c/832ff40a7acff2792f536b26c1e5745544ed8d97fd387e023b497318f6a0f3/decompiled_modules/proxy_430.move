module 0x1c832ff40a7acff2792f536b26c1e5745544ed8d97fd387e023b497318f6a0f3::proxy_430 {
    struct PROXY_430 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROXY_430>, arg1: 0x2::coin::Coin<PROXY_430>) {
        0x2::coin::burn<PROXY_430>(arg0, arg1);
    }

    public fun dispense(arg0: &mut 0x2::coin::TreasuryCap<PROXY_430>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROXY_430> {
        0x2::coin::mint<PROXY_430>(arg0, arg1, arg2)
    }

    public entry fun dispense_to(arg0: &mut 0x2::coin::TreasuryCap<PROXY_430>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROXY_430>>(0x2::coin::mint<PROXY_430>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PROXY_430, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROXY_430>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROXY_430>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROXY_430>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

