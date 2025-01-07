module 0x3fd4158cd1ac83ca81e9669949345d094a818c9c249d44350d73859d747ec04f::br {
    struct BR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BR>(arg0, 9, b"BR", b"Badrex", b"Nice token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e764aab2-878b-49b8-bd48-ed6ab022b51a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BR>>(v1);
    }

    // decompiled from Move bytecode v6
}

