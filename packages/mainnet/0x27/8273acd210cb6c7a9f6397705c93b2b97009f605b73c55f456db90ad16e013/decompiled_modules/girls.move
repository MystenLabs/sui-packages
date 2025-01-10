module 0x278273acd210cb6c7a9f6397705c93b2b97009f605b73c55f456db90ad16e013::girls {
    struct GIRLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GIRLS>(arg0, 6, b"GIRLS", b"Girls.Ai by SuiAI", b"Girls Coin is built on the Sui network. It utilizes intelligent algorithms to offer users highly efficient blockchain data processing services. This enables users to make precise decisions within the crypto world and drives the development of the entire ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2090_2033914711.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GIRLS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRLS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

