module 0xab11819ea744a488a04aac86397cc232ce6440df536b28b9bbda6e0a62a644f0::ktntk {
    struct KTNTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTNTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTNTK>(arg0, 9, b"KTNTK", b"Kotenotuka", b"Meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b22f7294-7500-4df6-bab7-95acb5ed1e2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTNTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KTNTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

