module 0x13f90125c2acee8308bebf0ad26fc3be25c8f8b4dc47f6fed2515f7294e9790a::jyotika {
    struct JYOTIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JYOTIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JYOTIKA>(arg0, 9, b"JYOTIKA", b"Jyoti", b"Cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1dfeb0a1-6e8a-4954-9fd1-da790b296a0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JYOTIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JYOTIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

