module 0x1601b2a749a79ab956e0c835a10171a9e8c7dba3c70cc95989cbf888fd4e2041::rober {
    struct ROBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBER>(arg0, 9, b"ROBER", b"STORE", b"Meme coin looking good in Dior normally has yujha ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/929350df-7b16-43bf-913d-cf6eb4229567.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

