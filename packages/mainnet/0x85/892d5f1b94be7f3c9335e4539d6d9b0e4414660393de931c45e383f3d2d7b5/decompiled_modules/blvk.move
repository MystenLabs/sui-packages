module 0x85892d5f1b94be7f3c9335e4539d6d9b0e4414660393de931c45e383f3d2d7b5::blvk {
    struct BLVK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLVK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLVK>(arg0, 9, b"BLVK", b"Black Snake", b"BLVK IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/618/664/large/gu-junyi-1737.jpg?1728044958")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLVK>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLVK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLVK>>(v1);
    }

    // decompiled from Move bytecode v6
}

