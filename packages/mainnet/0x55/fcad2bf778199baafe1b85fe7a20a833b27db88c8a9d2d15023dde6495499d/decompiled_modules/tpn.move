module 0x55fcad2bf778199baafe1b85fe7a20a833b27db88c8a9d2d15023dde6495499d::tpn {
    struct TPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPN>(arg0, 9, b"TPN", b"tired pana", b"TIRED PANDA PRESENTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5634839e-f498-4aea-96c0-ba82c9e50e49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

