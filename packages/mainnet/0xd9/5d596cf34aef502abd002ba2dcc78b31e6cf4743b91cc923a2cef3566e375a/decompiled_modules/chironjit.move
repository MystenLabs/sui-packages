module 0xd95d596cf34aef502abd002ba2dcc78b31e6cf4743b91cc923a2cef3566e375a::chironjit {
    struct CHIRONJIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIRONJIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIRONJIT>(arg0, 9, b"CHIRONJIT", b"CJ", b"Nothing just token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fefce57-82a5-4e46-984a-1083a8475310.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIRONJIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIRONJIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

