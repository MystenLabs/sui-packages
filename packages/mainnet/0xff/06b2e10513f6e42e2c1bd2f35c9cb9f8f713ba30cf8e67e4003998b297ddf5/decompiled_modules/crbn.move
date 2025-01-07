module 0xff06b2e10513f6e42e2c1bd2f35c9cb9f8f713ba30cf8e67e4003998b297ddf5::crbn {
    struct CRBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRBN>(arg0, 9, b"CRBN", b"Cryptobun", b"in crypto and blockchain i was born and grow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd772ee0-5cd2-4f15-98e8-3706ed10713a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

