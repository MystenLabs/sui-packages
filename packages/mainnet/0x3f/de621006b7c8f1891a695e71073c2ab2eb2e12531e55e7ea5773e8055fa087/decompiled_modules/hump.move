module 0x3fde621006b7c8f1891a695e71073c2ab2eb2e12531e55e7ea5773e8055fa087::hump {
    struct HUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMP>(arg0, 6, b"HUMP", b"Humphrey Thirsty for Liquidity", b"In a market that is starving for real liquidity, Humphrey is the oasis on Sui. Forget being stuck in some illiquid wasteland of failed memes. Just like a camel can chug 100 liters of water in minutes, Humphreys liquidity is infinite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_1bfd48b848.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

