module 0x8fe7ce2e4ff79031bb5535a8a4bb7b13a9ccf934118c457f73e2a065354dda7b::teslafart {
    struct TESLAFART has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESLAFART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESLAFART>(arg0, 9, b"Teslafart", b"Teslafart2.0", b"Make 1000x with Teslafart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxaGHG7bgEHm_Hy6vvd1GGxjc8sXrt-LWgEQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESLAFART>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESLAFART>>(v2, @0xc1c4d21dfdd006727022c89a18bbbe0f7994ea019a5069bedfcbb72a4c898f7e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESLAFART>>(v1);
    }

    // decompiled from Move bytecode v6
}

