module 0x39c1e2f88c10b3080b645d9b84cc6126ce4302226426011098351810f1829f0d::dsw {
    struct DSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSW>(arg0, 9, b"DSW", b"doubleswan", b"two swans are flying go with them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57c1fcfc-321f-44bb-88c6-b1ad4340ca72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSW>>(v1);
    }

    // decompiled from Move bytecode v6
}

