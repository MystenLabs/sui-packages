module 0xc123fc1d046dc6c4b883a8f5941a9436e71a138739b9ca3cd04b16095353bf2a::spookymeme {
    struct SPOOKYMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOKYMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOKYMEME>(arg0, 9, b"SPOOKYMEME", b"SPOOKYBABY", b"Meme Token Spooky Knight Family in Kingdom 3346 Rise Of Kingdoms", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa113895-8c8d-4288-af91-7d27aa2af5f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOKYMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPOOKYMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

