module 0xfbd40c499fc25f5ced8920e1cf4bec9b263b18be0ac995c02881fbf555c7b7c1::gpt {
    struct GPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPT>(arg0, 6, b"GPT", b"GPT Protocol", b"GPT Protocol aims to build Web3s largest generative AI network. It is a layer 2 blockchain that aims to commoditize AI compute power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/oljd_Yhi_Q_400x400_fb3ca33995.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

