module 0x4bdfc394768615a2318f48f83e3c90a0ec594e7b377346de4a1e8870761c0465::cguy {
    struct CGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGUY>(arg0, 9, b"CGUY", b"CHILGUYSUI", b"Chilguy Token is a new meme token that is here to enliven the cryptocurrency ecosystem, especially for the community of meme lovers and innovation in blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa310dc8-63e9-48a2-bcd7-1b1b0ea75d18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

