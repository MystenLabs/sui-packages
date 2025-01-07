module 0x363e7c7c7c70c568ddb41f1d0d10a4859bebc90640baba8ac7096b95ffcaf13b::mb {
    struct MB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MB>(arg0, 9, b"MB", b"MOON BULL", b"MOON BULL is a sustainable cryptocurrency aimed at promoting eco-friendly initiatives. By supporting green projects and renewable energy solutions, EcoCoin empowers users to make a positive impact on the environment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bc45deb-abf8-407b-bedf-9133e475ae7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MB>>(v1);
    }

    // decompiled from Move bytecode v6
}

