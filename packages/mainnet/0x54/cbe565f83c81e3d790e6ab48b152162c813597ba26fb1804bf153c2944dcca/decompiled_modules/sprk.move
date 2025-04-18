module 0x54cbe565f83c81e3d790e6ab48b152162c813597ba26fb1804bf153c2944dcca::sprk {
    struct SPRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRK>(arg0, 6, b"SPRK", b"SUISPARK", b"SuiSpark (SPRK) Token is a dynamic cryptocurrency built on the Sui blockchain, designed to ignite innovation and community engagement. With fast, low-cost transactions and strong scalability, SuiSpark powers decentralized applications, rewards systems, and staking opportunities. It aims to create a thriving ecosystem where users can collaborate, grow, and benefit from cutting-edge blockchain technology, while sparking new possibilities in the digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013390_b9b6bf25a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

