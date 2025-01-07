module 0xcacaf55783fb79492bedb75ed07f65e82496073ce741b479008b8b1e369945e0::naa {
    struct NAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAA>(arg0, 6, b"NAA", b"Nalita", b"We will launch a new token called **** (the name will be revealed in the future), we will put together an LP with RAY that will help keep the price of RAY stable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/810e58b4_d6dc_48a7_9397_68cf56a417df_569e0540fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

