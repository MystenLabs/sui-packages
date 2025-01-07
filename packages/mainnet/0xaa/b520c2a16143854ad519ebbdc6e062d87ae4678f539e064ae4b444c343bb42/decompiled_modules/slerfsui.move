module 0xaab520c2a16143854ad519ebbdc6e062d87ae4678f539e064ae4b444c343bb42::slerfsui {
    struct SLERFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLERFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLERFSUI>(arg0, 6, b"SLERFSUI", b"Slerf Sui", b"im a sloth. Slerf has no underlying value", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Slerf_11d9dcae0f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLERFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLERFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

