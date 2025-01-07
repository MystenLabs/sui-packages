module 0xd674dfad7003d5cc7177900d1af0cff2fb7a13182ba051742e9653eac29ae78e::ftc {
    struct FTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTC>(arg0, 9, b"FTC", b"FortuneCat", b"The good luck cat token that brings good fortunes to your crypto trades and portfolio. Keep some of it on your wallet and watch your trades ends in profit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02ff0a8c-abbc-47cc-9224-7b8d3c61ede7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

