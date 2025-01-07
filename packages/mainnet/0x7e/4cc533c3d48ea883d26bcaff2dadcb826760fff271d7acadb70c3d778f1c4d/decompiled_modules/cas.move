module 0x7e4cc533c3d48ea883d26bcaff2dadcb826760fff271d7acadb70c3d778f1c4d::cas {
    struct CAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAS>(arg0, 9, b"CAS", b"Cash-Out", b"The best meme coin to boost the joy of cash out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08dd36e1-6975-4f51-a479-7e962b3b14e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

