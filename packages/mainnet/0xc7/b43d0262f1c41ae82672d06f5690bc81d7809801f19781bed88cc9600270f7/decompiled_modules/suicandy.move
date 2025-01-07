module 0xc7b43d0262f1c41ae82672d06f5690bc81d7809801f19781bed88cc9600270f7::suicandy {
    struct SUICANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICANDY>(arg0, 9, b"suiCANDY", b"Sui Candy", b"SUICANDY IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.namu.wiki/i/ADEIzDhtzoH_5iK2w5ZKV35jMBQe8zBVd7W3i8lDtCxVYgGwG-tOnmyoqS-uDy_8D7mOdfQGRrNCSh4Ti9JoYA.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICANDY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICANDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

