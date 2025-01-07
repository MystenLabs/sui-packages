module 0x263fe3c9cdf3d64f80df5f3be5e4eae820fea32a5e50f5d2c0cb17ec42d8c99::suielf {
    struct SUIELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIELF>(arg0, 9, b"suielf", b"Sui Elf", b"SUIELF IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/705/688/large/-elf-viewport-124.jpg?1728310754")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIELF>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIELF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

