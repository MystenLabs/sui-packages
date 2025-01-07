module 0x30a83a261c6bcbf483d1bc6d217d73d2b318fff520f627786b605e05e9f42326::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 6, b"BLUB", b"Blub on Sui", x"20426c7562206973207468652062696767657374207768616c65206f6e205375692c206e6f206f6e6520697320626967676572207468616e20626c75622e0a0a24424c55422077696c6c206c61756768207468652068656c6c206f7574206f6620796f7520697320796f7520736d616c6c6572207468616e2068696d206f72206865722c2077686f207466206b6e6f772e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/blub2_1_16a4f032e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

