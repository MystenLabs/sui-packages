module 0xcec6cf6f00cc65d5064fff3f63289114125cbde973b4807a64fac4b0427d94e::ntl {
    struct NTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTL>(arg0, 9, b"NTL", b"Dragon ", b"when whales fly that is my hope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06d5bfac-6c74-4671-a9fb-2d88b1cbe877.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

