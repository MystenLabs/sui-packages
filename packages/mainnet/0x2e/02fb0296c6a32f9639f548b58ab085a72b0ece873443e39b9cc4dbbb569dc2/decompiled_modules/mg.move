module 0x2e02fb0296c6a32f9639f548b58ab085a72b0ece873443e39b9cc4dbbb569dc2::mg {
    struct MG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MG>(arg0, 9, b"MG", b"Memegirls ", b"Memefi girls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d609724e-ca71-42bd-9ede-79f5c50eab81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MG>>(v1);
    }

    // decompiled from Move bytecode v6
}

