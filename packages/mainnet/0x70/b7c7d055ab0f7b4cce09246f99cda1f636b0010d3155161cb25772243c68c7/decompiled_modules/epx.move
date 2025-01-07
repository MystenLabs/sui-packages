module 0x70b7c7d055ab0f7b4cce09246f99cda1f636b0010d3155161cb25772243c68c7::epx {
    struct EPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPX>(arg0, 9, b"EPX", b"EchoPlex", b"EchoPlex (EPX) is a revolutionary utility token powering an AI-driven, decentralized echo-system for social and environmental impact.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08f72a68-7b46-4fc2-81fd-34b3b1a71a01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

