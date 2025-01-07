module 0xbad11d91e2f44b3e75c6fcc77656b35857fd3b60ec7c6bf3396cdbeaadf0c39d::chatgpt {
    struct CHATGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHATGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHATGPT>(arg0, 9, b"CHATGPT", b"GPT", b"ChatGPT is a state-of-the-art AI chatbot developed by OpenAI. Its ability to provide comprehensive and informative responses makes it a versatile tool for various tasks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8806733c-4865-4a4f-8d9a-99b216776cd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHATGPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHATGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

