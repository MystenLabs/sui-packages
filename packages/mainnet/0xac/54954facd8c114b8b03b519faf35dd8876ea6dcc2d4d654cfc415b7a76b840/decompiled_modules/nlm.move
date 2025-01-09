module 0xac54954facd8c114b8b03b519faf35dd8876ea6dcc2d4d654cfc415b7a76b840::nlm {
    struct NLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLM>(arg0, 6, b"NLM", b"Nvidia AI Agent Language Model", b"Nvidia AI Agent Language Model is an intelligent AI agent designed to assist, adapt, and make your tasks easier with seamless efficiency and a user-friendly approach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3a9c39b2_bac3_4d8f_a885_2b8734b1ddce_f667b89914.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

