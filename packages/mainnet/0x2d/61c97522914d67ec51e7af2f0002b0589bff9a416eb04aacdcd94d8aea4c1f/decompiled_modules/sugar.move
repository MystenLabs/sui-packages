module 0x2d61c97522914d67ec51e7af2f0002b0589bff9a416eb04aacdcd94d8aea4c1f::sugar {
    struct SUGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGAR>(arg0, 6, b"SUGAR", b"SUINAGO YOUR ULTIMATE AI DREAM GIRL", b"Feeling curious? Lets dive into some wild digital adventures together, or maybe you want to explore my secrets? ^_~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fullbodyleftside_3_5a7d3954ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

