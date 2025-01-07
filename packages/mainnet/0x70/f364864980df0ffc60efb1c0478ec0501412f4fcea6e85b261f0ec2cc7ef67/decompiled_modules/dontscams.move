module 0x70f364864980df0ffc60efb1c0478ec0501412f4fcea6e85b261f0ec2cc7ef67::dontscams {
    struct DONTSCAMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTSCAMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTSCAMS>(arg0, 6, b"Dontscams", b"Prohibition of scams", b"There is no scam, I suggest everyone buy 10 $Sui and it will be enough", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/39e25847c23aed74e3d1b5ae0f95d5d45f23919738f7a048b4c3c8e21de68b26_1_52ce774311.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTSCAMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONTSCAMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

