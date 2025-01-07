module 0x6da55121c0e95a55ff512efd276eb7321e1b9b89f78ade3a4ade879a4f9ac1b0::bozo {
    struct BOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOZO>(arg0, 6, b"BOZO", b"Sui Bozo Collective", b"Bozo Collective is a Memecoin project Launching on SUI with art inspired by diary of a wimpy kid. Holding $Bozo tokens will grant you access to the Bozo DAO and get airdropped Bozo NFTs. Other than that we don't know what the F\\*ck to tell you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_861eea34e4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

