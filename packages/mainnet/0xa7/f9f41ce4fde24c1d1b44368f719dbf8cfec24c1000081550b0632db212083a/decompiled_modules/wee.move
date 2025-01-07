module 0xa7f9f41ce4fde24c1d1b44368f719dbf8cfec24c1000081550b0632db212083a::wee {
    struct WEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEE>(arg0, 9, b"WEE", b"Weeders", b"A token  to legalize marijuana globally ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1661089b-bfc0-413a-be93-b24511d14114.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

