module 0x1cf58aa4c73ba443269c90c3b2f4116134a7441bb29e2d7eb45fd2b0a66166ac::dml {
    struct DML has drop {
        dummy_field: bool,
    }

    fun init(arg0: DML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DML>(arg0, 9, b"DML", b"Dhamal", b"Dhamal is native meme coin by sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f18b935-bc05-4667-823c-b27a88aeaca5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DML>>(v1);
    }

    // decompiled from Move bytecode v6
}

