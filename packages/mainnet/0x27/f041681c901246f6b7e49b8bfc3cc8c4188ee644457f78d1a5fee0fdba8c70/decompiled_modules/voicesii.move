module 0x27f041681c901246f6b7e49b8bfc3cc8c4188ee644457f78d1a5fee0fdba8c70::voicesii {
    struct VOICESII has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOICESII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOICESII>(arg0, 6, b"VOICESII", b"VoiceSii", b"VoiceSii is a new social media platform where users can record and share 10-second voice memos on VoiceSii.nl. By holding $VOICESII, you become part of this innovative voice-driven community. Join now and make your voice heard!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742560202523.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOICESII>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOICESII>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

