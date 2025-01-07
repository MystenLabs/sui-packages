module 0xef215c584cecbe8a40bb2eb6de4ab1fd486a2ef362acc688f23f6e8fc47047c4::shn {
    struct SHN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHN>(arg0, 9, b"SHN", b"shinobi", b"It is a warrior for justice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63806a0d-668b-4d32-87b2-cee1dd104cbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHN>>(v1);
    }

    // decompiled from Move bytecode v6
}

