module 0x3bb9909867d45f500d1b7eb197838343507028e08f172eaab0b91d522b4196c5::tamirunato {
    struct TAMIRUNATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMIRUNATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMIRUNATO>(arg0, 9, b"Tamirunato", b"Tamiru", b"Tamirunatomika", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://t3.ftcdn.net/jpg/08/54/19/18/360_F_854191873_ElcqjdDBz9HuTZI5fE4Lhp9EnatY0Yed.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TAMIRUNATO>(&mut v2, 18000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMIRUNATO>>(v2, @0x3e6f93f81e9cc2660e8eb52283f5c8c06c04abc6920ffa99bd849d3da0ddccee);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAMIRUNATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

