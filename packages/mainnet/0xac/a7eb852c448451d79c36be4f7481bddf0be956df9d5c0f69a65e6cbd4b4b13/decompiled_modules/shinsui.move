module 0xaca7eb852c448451d79c36be4f7481bddf0be956df9d5c0f69a65e6cbd4b4b13::shinsui {
    struct SHINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINSUI>(arg0, 6, b"Shinsui", b"SHINSUI The Shiba Origins", b"The Shinsui, represents not just a regional variant but a significant part of the Shiba Inu's journey towards becoming one of Japan's most beloved and emblematic breeds, recognized global. The Shinsui possessed a solid undercoat, with a dense layer of guard hairs, and were small and red in color. The Shinsui refers to a specific lineage of the Shiba Inu dog breed, known for preserving the original characteristics of the Shiba Inu as they were in the Nagano Prefecture of Japan!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shinsui_d41041a129.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHINSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

