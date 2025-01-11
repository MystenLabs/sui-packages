module 0xf88d8da51453b0ada80a873d2fc948be7eb7150e0e927d1feb5a8c7bc275f60c::azura {
    struct AZURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZURA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AZURA>(arg0, 6, b"AZURA", b"Sui Azura AI by SuiAI", b"Azura AI is a versatile language model designed to assist users with a wide range of tasks, including answering questions, generating creative content, providing personalized advice, and facilitating technical projects. Built on advanced natural language processing capabilities, Azura AI is trained to understand context, offer insightful responses, and adapt to diverse conversational needs. It emphasizes clarity, efficiency, and a user-friendly experience while fostering collaboration and creativity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SQ_Xuv_V5_400x400_37d135be42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AZURA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZURA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

