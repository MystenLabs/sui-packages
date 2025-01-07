module 0x3a1256b6e9e27dedec88871e84825973f1999d097919b0d7905c771c61a6a7ef::lea {
    struct LEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEA>(arg0, 9, b"LEA", b"League", b"League of Legend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5415338-71eb-4f2f-85f5-25ec3b13b46f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

