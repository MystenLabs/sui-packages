module 0xa40fe6253e2fc0964354104ca0a6148b43aff6ad0634a7db3a0d863f7f22fd63::kapsui {
    struct KAPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPSUI>(arg0, 6, b"Kapsui", b"KaPpA on Sui", b"Kappa is one of the many creatures of Japanese folklore. His origin goes back to the Edo era where he was considered as a malicious and dangerous being. It was even not recommended for children to get too close to rivers. Indeed, he was known to attract men in order to sink them and to eat their flesh. That is why even now it's possible to find old signs with \"Be aware of Kappa\" written on it near the rivers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KAPPA_b00f1f7750.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

