module 0x69515eb1159f8d908d09eaed919bf7627305fb6db061ba74aa9b7be4d706164::good12 {
    struct GOOD12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOD12>(arg0, 9, b"GOOD12", b"@meme14", b"Mamaola", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/297ed234-5068-4560-a50a-d07da213296a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOD12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOD12>>(v1);
    }

    // decompiled from Move bytecode v6
}

