module 0xe1bf74c46ef53624d1aad185833ef5611073e4587b151716f673ee4068c35a9c::tnm {
    struct TNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNM>(arg0, 9, b"TNM", b"Tsunami", x"4c6574e2809973206d616b65207761766573206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f069c9e1-c598-41df-9607-4ac152659a64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

