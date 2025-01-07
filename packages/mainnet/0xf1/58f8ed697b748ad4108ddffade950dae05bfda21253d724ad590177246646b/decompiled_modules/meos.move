module 0xf158f8ed697b748ad4108ddffade950dae05bfda21253d724ad590177246646b::meos {
    struct MEOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOS>(arg0, 6, b"MEOS", b"MEME OS", b"MEME OS is the operating system platform for Meme projects on Sui Network | Website https://www.memeos.online", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bdogbg_b60e47e32b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

