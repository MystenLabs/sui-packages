module 0xb3eca7b344530dd07314e8ea52aedbd21a7b71dc74c7a51a8774511ec8bbb6a0::kl {
    struct KL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KL>(arg0, 9, b"KL", b"Ky", b"Ky lua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56af999f-3160-449a-b634-ab96c115a6fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KL>>(v1);
    }

    // decompiled from Move bytecode v6
}

