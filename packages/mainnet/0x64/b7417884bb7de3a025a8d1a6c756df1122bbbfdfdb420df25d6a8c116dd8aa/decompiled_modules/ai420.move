module 0x64b7417884bb7de3a025a8d1a6c756df1122bbbfdfdb420df25d6a8c116dd8aa::ai420 {
    struct AI420 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI420, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI420>(arg0, 6, b"AI420", b"Artificial Idiots", x"4576656e20746865206d616368696e65732063616e206861766520736f6d6520656d657267696e6720206964696f7473206f66207468656972206f776e2e200a414934323020446567656e20746563682e200a47756420546563682e0a68747470733a2f2f742e6d652f416964696f7473737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_asked_gpt_to_generate_an_meme_that_only_ai_will_understand_v0_jwjv908nm3tc1_a2180aa49a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI420>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI420>>(v1);
    }

    // decompiled from Move bytecode v6
}

