module 0xf2f66c857f0aef275629c5d249dfc3dd357d8de3dedce3722d96b5867135bd36::dvl {
    struct DVL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DVL>(arg0, 9, b"DVL", b"Devil", b"The red devil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30d952ba-07b4-44f1-972b-9b8949538aaa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DVL>>(v1);
    }

    // decompiled from Move bytecode v6
}

