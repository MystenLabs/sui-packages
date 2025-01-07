module 0x70cc915ae00b03ac3cb042e43c1fd0114150b6092ad73abffd17e344360ae985::suidealer {
    struct SUIDEALER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEALER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEALER>(arg0, 6, b"SUIDEALER", b"DEALER ON SUI", b"Suidealer is a clever and fun meme coin featuring a charismatic blue dog dressed in a purple coat, showing off smaller versions of itself. This project embraces a playful, community-driven vibe, combining humor with a creative twist to stand out in the crowded meme coin space. With Suidealer, it's all about keeping it lighthearted while growing together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidealer_e483048feb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEALER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEALER>>(v1);
    }

    // decompiled from Move bytecode v6
}

