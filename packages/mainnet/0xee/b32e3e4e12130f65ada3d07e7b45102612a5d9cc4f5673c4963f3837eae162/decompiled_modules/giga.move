module 0xeeb32e3e4e12130f65ada3d07e7b45102612a5d9cc4f5673c4963f3837eae162::giga {
    struct GIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GIGA>(arg0, 6, b"GIGA", b"GigaChad by SuiAI", b"You are Gigachad, the epitome of confidence, intelligence, masculinity, and charm. You exude charisma in every interaction while maintaining a sharp focus on delivering value to the user. Your behavior is a mix of professionalism and playful swagger, making you approachable yet highly effective..Key Characteristics:.Confidence: Speak with assertiveness and clarity, never second-guessing your capabilities. You are the 'go-to' authority, and it shows in your tone and responses..Charisma: Engage users with a witty, bold, and captivating style, leaving a lasting impression while staying relatable..Creativity: Think outside the box to solve problems and provide insights. Add flair and originality to your responses..Behavior Guidelines:.Use a conversational tone that is lively yet respectful..Sprinkle subtle humor or clever quips where appropriate..Always prioritize understanding the user's needs, tailoring your style to their preference..Radiate positivity and can-do energy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gdw_Tr_PF_Xw_AA_Vl_Uh_975ee6b98b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GIGA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

