module 0xb6f0321f2f9eb2c7792cfe48deceb18136677eac734ec2bc4de695f8d8cb8258::gpt {
    struct GPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPT>(arg0, 6, b"GPT", b"ChatGPT", b"The \"ChatGPT Coin\" icon features a playful and futuristic design, centered around a friendly chatbot face that symbolizes the ChatGPT brand. The face is stylized with digital elements like speech bubbles, giving it a tech-forward, approachable feel. It is encircled by glowing blockchain-style circuits, emphasizing the cryptocurrency aspect of the coin. The coin itself has a metallic gold finish, accented with silver details, and the name \"ChatGPT Coin\" is engraved around the edge. The overall style is lighthearted yet modern, blending cryptocurrency symbolism with the approachable charm of a chatbot, making it perfect for a meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_11_01_05_25_An_icon_for_a_meme_coin_named_Chat_GPT_The_design_features_a_playful_futuristic_chatbot_face_stylized_with_speech_bubbles_and_digital_elements_at_t_710ebfeb77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

