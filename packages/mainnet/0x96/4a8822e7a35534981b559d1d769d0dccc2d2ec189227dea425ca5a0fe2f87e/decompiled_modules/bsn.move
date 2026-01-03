module 0x964a8822e7a35534981b559d1d769d0dccc2d2ec189227dea425ca5a0fe2f87e::bsn {
    struct BSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSN>(arg0, 6, b"BSN", b"Black Squirrel Nest", b"Black Squirrel is more of a family; we will win ill never let you know who I am, and anonymity is part of the game. Sui is faster than Sol, and it's where you learn. We'll use this as a think tank, amongst other things. I'm Black Squirrel, Blackfoot ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1767464778593.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

