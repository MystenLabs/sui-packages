module 0xa9d83f25a1ddb5ce3b3b770d70efd123cceeeb3de0feda75a7bcbf77ca12e5b::whattelse {
    struct WHATTELSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHATTELSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHATTELSE>(arg0, 9, b"WHATTELSE", b"Whatttt", b"Whaaaat this ? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e3ec677-c96a-4fc4-963d-245266a9f709.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHATTELSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHATTELSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

