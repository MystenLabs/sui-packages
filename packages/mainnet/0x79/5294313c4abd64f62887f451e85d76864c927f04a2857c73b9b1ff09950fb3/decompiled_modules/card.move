module 0x795294313c4abd64f62887f451e85d76864c927f04a2857c73b9b1ff09950fb3::card {
    struct CARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARD>(arg0, 6, b"CARD", b"reverse", b"THE REVERSE TOKEN CARD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zeo_H_Kf_WAAA_Hf_Fi_5943fc5eed.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

