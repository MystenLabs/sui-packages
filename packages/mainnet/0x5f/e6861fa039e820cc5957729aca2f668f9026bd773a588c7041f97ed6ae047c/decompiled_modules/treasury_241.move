module 0x5fe6861fa039e820cc5957729aca2f668f9026bd773a588c7041f97ed6ae047c::treasury_241 {
    struct TREASURY_241 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_241>, arg1: 0x2::coin::Coin<TREASURY_241>) {
        0x2::coin::burn<TREASURY_241>(arg0, arg1);
    }

    fun init(arg0: TREASURY_241, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURY_241>(arg0, 9, b"veHAEDAL", b"Haedal Protocol", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-6SJZ3wK7nF.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TREASURY_241>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURY_241>>(v1);
    }

    public fun issue(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_241>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TREASURY_241> {
        0x2::coin::mint<TREASURY_241>(arg0, arg1, arg2)
    }

    public entry fun issue_to(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_241>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TREASURY_241>>(0x2::coin::mint<TREASURY_241>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

