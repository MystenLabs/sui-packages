module 0x1e75d7d647e2f5598ce3d696b40b94cc1978211efd1fd3f6ad09f74fb72be1f4::rj {
    struct RJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RJ>(arg0, 9, b"RJ", b"Red Joker", b"Future holder is win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/865b224b-fc00-4818-8df3-f9393090b68b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

