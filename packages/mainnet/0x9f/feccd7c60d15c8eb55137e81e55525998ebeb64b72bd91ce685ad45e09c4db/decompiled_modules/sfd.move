module 0x9ffeccd7c60d15c8eb55137e81e55525998ebeb64b72bd91ce685ad45e09c4db::sfd {
    struct SFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFD>(arg0, 9, b"SFD", b"Sofa dog", b"A happy dog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cad8939d-fe45-4326-894c-6cec4dd8f83d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

