module 0x78a7e143d66d75ba66a1bedb52e31e95d1bced435511c302ef0516259efdb2c6::kamala {
    struct KAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALA>(arg0, 9, b"KAMALA", b"$KAMALA H", b"$KAMALA is the meme of Kamala Harris the Democratic Nominee of the Presential Elections 2024. The ticker is Kamala.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cac1aeaa-ee16-4456-877d-91e94ffa11bd-1000018850.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

