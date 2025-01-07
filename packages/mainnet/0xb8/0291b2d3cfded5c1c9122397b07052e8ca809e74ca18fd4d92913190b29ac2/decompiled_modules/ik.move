module 0xb80291b2d3cfded5c1c9122397b07052e8ca809e74ca18fd4d92913190b29ac2::ik {
    struct IK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IK>(arg0, 9, b"IK", b"Ikay", b"Just a chill dude, out here to chill and relax.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4ab01ca-8ba5-4316-a4d4-b9f300a73db7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IK>>(v1);
    }

    // decompiled from Move bytecode v6
}

