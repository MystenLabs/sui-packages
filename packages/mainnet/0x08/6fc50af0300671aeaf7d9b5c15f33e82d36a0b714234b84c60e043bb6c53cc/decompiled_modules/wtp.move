module 0x86fc50af0300671aeaf7d9b5c15f33e82d36a0b714234b84c60e043bb6c53cc::wtp {
    struct WTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTP>(arg0, 6, b"WTP", b"We The People", b"\"We the People\" is a movement for uniting the crypto community. Born from the spirit of decentralization and inclusivity, our coin aims to empower and support a new wave of crypto enthusiasts, investors, and developers. We believe in a future where everyone has a voice and a stake in the digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_19_140041_f04544dc98.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

