module 0x83fe98aebc2ab025dd62a05e57fd96db173f9a6cff0ba5cf78d38af8578e4118::bgirl {
    struct BGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGIRL>(arg0, 9, b"BGIRL", b"BABYGIRL", b"Cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47070699-fad9-4fe6-9f88-fe5dd24fa170.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

