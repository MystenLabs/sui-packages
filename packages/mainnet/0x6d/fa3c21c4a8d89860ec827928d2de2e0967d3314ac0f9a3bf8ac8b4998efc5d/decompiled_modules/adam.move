module 0x6dfa3c21c4a8d89860ec827928d2de2e0967d3314ac0f9a3bf8ac8b4998efc5d::adam {
    struct ADAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAM>(arg0, 9, b"ADAM", b"Adam", b"Adam ah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d24837d-ccc7-4d90-84b8-6aa730cf5c93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

