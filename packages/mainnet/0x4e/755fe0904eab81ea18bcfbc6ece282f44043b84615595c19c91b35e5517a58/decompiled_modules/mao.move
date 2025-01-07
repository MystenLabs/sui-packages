module 0x4e755fe0904eab81ea18bcfbc6ece282f44043b84615595c19c91b35e5517a58::mao {
    struct MAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAO>(arg0, 6, b"MAO", b"MAO SUI THE CAT", b"i'm Mao, i've been through a lot in life - many life changing ups and crazy downs - at this point it's all the same to me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66ddbb1abf85e5b5b66a216f_256x256_59dc735c81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

