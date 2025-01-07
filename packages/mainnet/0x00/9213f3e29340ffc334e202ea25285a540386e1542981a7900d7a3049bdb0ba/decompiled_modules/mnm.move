module 0x9213f3e29340ffc334e202ea25285a540386e1542981a7900d7a3049bdb0ba::mnm {
    struct MNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNM>(arg0, 9, b"MNM", b"MoonMan", b"MoonMan invites collectors and enthusiasts to embark on a journey beyond the stars, capturing the imagination of those who dream of the unknown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/495680cf-ed67-4bc3-99cc-4138f4e05ed3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

