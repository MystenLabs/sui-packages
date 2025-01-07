module 0x8af3643cda85d6679a887384534a0612436392801059e7ce77307caf45fc03ba::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGMI>(arg0, 6, b"WAGMI", b"SUI WAGMI", x"57452041524520414c4c20474f4e4e41204d414b452049542e5355492043544f200a4920637265617465642074686973206a75737420666f722066756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9183f6e7_271d_460f_a234_a3061b0621b3_a64a0ba935.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

