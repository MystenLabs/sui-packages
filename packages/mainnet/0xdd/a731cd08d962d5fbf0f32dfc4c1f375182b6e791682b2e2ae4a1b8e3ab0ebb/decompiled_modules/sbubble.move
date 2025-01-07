module 0xdda731cd08d962d5fbf0f32dfc4c1f375182b6e791682b2e2ae4a1b8e3ab0ebb::sbubble {
    struct SBUBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUBBLE>(arg0, 9, b"SBUBBLE", b"Bubble on Sui", b"SBUBBLE IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F1000037492_ff2ecb5b4f.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBUBBLE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUBBLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBUBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

