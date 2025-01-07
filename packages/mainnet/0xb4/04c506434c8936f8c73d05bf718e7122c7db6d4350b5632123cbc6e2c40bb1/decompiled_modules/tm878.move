module 0xb404c506434c8936f8c73d05bf718e7122c7db6d4350b5632123cbc6e2c40bb1::tm878 {
    struct TM878 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TM878, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TM878>(arg0, 9, b"TM878", b"TM", b"Token for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/184c6e75-046f-4620-bd36-dd98fb7e7832.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TM878>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TM878>>(v1);
    }

    // decompiled from Move bytecode v6
}

