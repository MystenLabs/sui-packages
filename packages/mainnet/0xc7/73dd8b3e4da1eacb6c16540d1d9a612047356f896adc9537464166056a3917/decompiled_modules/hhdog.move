module 0xc773dd8b3e4da1eacb6c16540d1d9a612047356f896adc9537464166056a3917::hhdog {
    struct HHDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHDOG>(arg0, 9, b"HHDOG", b"Hop Hop Dog", b"First Dog on Hop mempad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ26_rTvgwNhmcylm4OqqEFiPIr0TQA4jPjHA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HHDOG>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HHDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

