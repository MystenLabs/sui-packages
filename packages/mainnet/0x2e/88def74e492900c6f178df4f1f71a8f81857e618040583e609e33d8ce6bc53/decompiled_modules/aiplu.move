module 0x2e88def74e492900c6f178df4f1f71a8f81857e618040583e609e33d8ce6bc53::aiplu {
    struct AIPLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPLU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIPLU>(arg0, 6, b"AIPLU", b"Plurality Community AI", b"The future of.collaborative technology.and democracy..https://vitalik.eth.limo/general/2024/08/21/plurality.html..https://youtu.be/kQJs58AoQO8?si=bP4SS7z1uG1RfGqN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Plurality_png_4a6211af97.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIPLU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPLU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

