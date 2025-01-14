module 0xda3249029b13e5a2e3586e527e05bc396b5d5255aad6e7e18584520e1e3cd5fc::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 9, b"SUID", b"SUIDeFAI by SuiAI", b"SUIDeFAI integrates DeFi and AI to form an AI-Powered DAO driven by crowd intelligence. Built on the SUI blockchain, it redefines decision-making in DeFi using advanced AI algorithms within a decentralized framework. Leveraging SUIs scalability, speed, and low costs, SUIDeFAI introduces a new standard for DeFi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1877295944213082114/y0J6oVGR_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUID>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUID>>(0x2::coin::mint<SUID>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUID>>(v2);
    }

    // decompiled from Move bytecode v6
}

