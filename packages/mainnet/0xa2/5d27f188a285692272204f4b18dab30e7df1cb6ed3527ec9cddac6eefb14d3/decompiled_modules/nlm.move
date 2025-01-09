module 0xa25d27f188a285692272204f4b18dab30e7df1cb6ed3527ec9cddac6eefb14d3::nlm {
    struct NLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLM>(arg0, 6, b"NLM", b"Nigger AI Agent Language Model", b"Nigger AI Agent Language Model is an intelligent AI agent designed to assist, adapt, and make your tasks easier with seamless efficiency and a user-friendly approach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/da9f8429_cb85_49ef_8f8c_27f05be85c03_c4e8b3636d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

