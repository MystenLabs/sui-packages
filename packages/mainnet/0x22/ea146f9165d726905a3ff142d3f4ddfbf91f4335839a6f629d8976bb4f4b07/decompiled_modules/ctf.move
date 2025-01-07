module 0x22ea146f9165d726905a3ff142d3f4ddfbf91f4335839a6f629d8976bb4f4b07::ctf {
    struct CTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTF>(arg0, 9, b"CTF", b"Catfish", b"cats and fishes are friends but sometimes cats love fishes more buy token and feed both.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d0624b2-bba6-4a2c-8057-c4c6b6a6237b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

