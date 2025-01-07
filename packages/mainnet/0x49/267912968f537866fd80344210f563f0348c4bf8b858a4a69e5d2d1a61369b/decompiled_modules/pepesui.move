module 0x49267912968f537866fd80344210f563f0348c4bf8b858a4a69e5d2d1a61369b::pepesui {
    struct PEPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUI>(arg0, 9, b"PEPESUI", b"PEPESUI", b"Pepe coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.stakingrewards.com/_next/image?url=https%3A%2F%2Fcoin-images.coingecko.com%2Fcoins%2Fimages%2F30251%2Flarge%2FSuiPePe_Logo_200x200.png%3F1696529160&w=3840&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPESUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

