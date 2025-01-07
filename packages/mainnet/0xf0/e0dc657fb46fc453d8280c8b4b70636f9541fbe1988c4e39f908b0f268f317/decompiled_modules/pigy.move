module 0xf0e0dc657fb46fc453d8280c8b4b70636f9541fbe1988c4e39f908b0f268f317::pigy {
    struct PIGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGY>(arg0, 9, b"PIGY", b"HYPE", b"HYPE OF DAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://onfido.com/wp-content/uploads/2024/03/Hype-Featured-Image-Customer-Case-Study-1200x628-1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIGY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

