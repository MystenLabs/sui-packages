module 0xd5960f82a522f0e714cd2109ceb3dc6a66118f01fbcb11f03591467b176966ac::suidown {
    struct SUIDOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOWN>(arg0, 6, b"SUIDOWN", b"WE WRESTLE EVERYTHING", b"WWE inspired Token we're SUI TOKEN joined in SMACKDOWN/SUIDOWN and ROYAL RUMBLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_05_30_174053_3d72e12a37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

