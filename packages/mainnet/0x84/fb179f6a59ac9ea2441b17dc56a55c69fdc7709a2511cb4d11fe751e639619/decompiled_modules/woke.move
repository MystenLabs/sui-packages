module 0x84fb179f6a59ac9ea2441b17dc56a55c69fdc7709a2511cb4d11fe751e639619::woke {
    struct WOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOKE>(arg0, 8, b"WOKE", b"RIP WOKE", x"52495020574f4b450a0a6f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/c48d09d6-9894-4a92-9c84-754414e5ded0.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOKE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

