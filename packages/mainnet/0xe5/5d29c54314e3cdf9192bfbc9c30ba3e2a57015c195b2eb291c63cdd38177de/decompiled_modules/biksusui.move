module 0xe55d29c54314e3cdf9192bfbc9c30ba3e2a57015c195b2eb291c63cdd38177de::biksusui {
    struct BIKSUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIKSUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIKSUSUI>(arg0, 6, b"BIKSUSUI", b"Biksu Sui", b"BIKSU SUI - More than just a meme coin, we are a fusion of martial arts mastery and blockchain innovation. Through humor, relatability, and a powerful community, we aim to be the ultimate marketing force for SUI, driving growth with every move. Enter the dojo. Kick first, ask questions later.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250430_233051_645_55c3e23e4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIKSUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIKSUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

