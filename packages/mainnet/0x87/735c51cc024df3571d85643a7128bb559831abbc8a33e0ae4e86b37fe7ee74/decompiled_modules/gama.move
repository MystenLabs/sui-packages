module 0x87735c51cc024df3571d85643a7128bb559831abbc8a33e0ae4e86b37fe7ee74::gama {
    struct GAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GAMA>(arg0, 6, b"GAMA", b"G.A.M.A", b"GAMA empowers AI agents to operate autonomously, processing inputs and generating responses while learning from past interactions. It enhances decision-making by leveraging long-term memory, including experiences, reflections, and dynamic personality traits. By continuously evaluating the outcomes of actions and conversations, GAMA enables agents to refine their knowledge and improve their planning and performance over time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Designer_4_3b7c8c369e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAMA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

