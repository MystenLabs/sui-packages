module 0xa5d5b827d1e5f7767b843995605bfd9d97dadb44e37b06bc2e9ea19363c66bfc::reserve_718 {
    struct RESERVE_718 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_718>, arg1: 0x2::coin::Coin<RESERVE_718>) {
        0x2::coin::burn<RESERVE_718>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_718>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RESERVE_718> {
        0x2::coin::mint<RESERVE_718>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_718>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESERVE_718>>(0x2::coin::mint<RESERVE_718>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RESERVE_718, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESERVE_718>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RESERVE_718>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESERVE_718>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

