module 0xa7d5a54277051871e9acd9701d12751d138b84e93c7b382eb6a26ce0efe7156f::wai {
    struct WAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WAI>(arg0, 6, b"WAI", b"WOLF AI by SuiAI", b"A decentralized, AI-powered ecosystem fostering creativity, inclusivity, and transparency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1001250103_a6ac812914.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

