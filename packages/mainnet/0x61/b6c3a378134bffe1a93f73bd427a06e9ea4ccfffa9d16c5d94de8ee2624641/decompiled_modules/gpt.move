module 0x61b6c3a378134bffe1a93f73bd427a06e9ea4ccfffa9d16c5d94de8ee2624641::gpt {
    struct GPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPT>(arg0, 6, b"GPT", b"GPT Protocol", b"GPT Protocol aims to build Web3s largest generative AI network. It is a layer 2 blockchain that aims to commoditize AI compute power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7ab62n2_L_400x400_5d58afd60e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

