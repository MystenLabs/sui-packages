module 0x95de4d76c3395aa6a532c72c0d9ceaf93c7e9f89c40a7a1dc79ae807a31bbf53::sui_inu {
    struct SUI_INU has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUI INU", b"SUIINU", b"SUI INU is a pioneering token on the Sui network, designed for decentralized gaming and betting applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjU7veNYvy8rLpnUgjzLOwKpA2_YyDPqJPYA&s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUI_INU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUI_INU>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUI_INU>(&mut v0, 10000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_INU>>(v0);
    }

    // decompiled from Move bytecode v6
}

