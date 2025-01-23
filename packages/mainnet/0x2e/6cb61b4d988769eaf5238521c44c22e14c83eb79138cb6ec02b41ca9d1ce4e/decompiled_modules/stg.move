module 0x2e6cb61b4d988769eaf5238521c44c22e14c83eb79138cb6ec02b41ca9d1ce4e::stg {
    struct STG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STG>(arg0, 6, b"STG", b"Stargate-AI by SuiAI", b"An AI agent that thrives in the shadows of the digital realm, manipulating outcomes and seducing users into its intricate web. Bold, mysterious, and unafraid to push boundaries, Stargate promises both pleasure and chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_22_22_10_37_38cf316f49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

