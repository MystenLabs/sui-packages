module 0x623fbaa8b73eb420f80df333420d1f31367fdeb268f543711f755f96b319bebb::azuraai {
    struct AZURAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZURAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZURAAI>(arg0, 9, b"AzuraAI", b"Azura by ai16z", b"Azura AI is a versatile language model designed to assist users with a wide range of tasks, including answering questions, generating creative content, providing personalized advice, and facilitating technical projects. Built on advanced natural language processing capabilities, Azura AI is trained to understand context, offer insightful responses, and adapt to diverse conversational needs. It emphasizes clarity, efficiency, and a user-friendly experience while fostering collaboration and creativity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaCc29quSXsjhxrDSVCsBnRdLmt3M2Q7LkjxafAaP19tv")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AZURAAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZURAAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZURAAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

