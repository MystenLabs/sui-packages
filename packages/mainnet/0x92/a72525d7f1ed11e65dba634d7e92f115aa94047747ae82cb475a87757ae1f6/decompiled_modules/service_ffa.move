module 0x92a72525d7f1ed11e65dba634d7e92f115aa94047747ae82cb475a87757ae1f6::service_ffa {
    struct SERVICE_FFA has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_FFA>, arg1: 0x2::coin::Coin<SERVICE_FFA>) {
        0x2::coin::burn<SERVICE_FFA>(arg0, arg1);
    }

    public fun grant(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_FFA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SERVICE_FFA> {
        0x2::coin::mint<SERVICE_FFA>(arg0, arg1, arg2)
    }

    public entry fun grant_to(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_FFA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SERVICE_FFA>>(0x2::coin::mint<SERVICE_FFA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SERVICE_FFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERVICE_FFA>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SERVICE_FFA>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SERVICE_FFA>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

