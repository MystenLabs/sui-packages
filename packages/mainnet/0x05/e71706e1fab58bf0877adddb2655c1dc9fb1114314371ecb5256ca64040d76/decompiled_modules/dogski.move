module 0x5e71706e1fab58bf0877adddb2655c1dc9fb1114314371ecb5256ca64040d76::dogski {
    struct DOGSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSKI>(arg0, 6, b"DOGSKI", b"Mike Wadogski (DOGSKI)", b"Mike Wazowski was exposed to radioactive fluid while entering the SUI network, which transformed his face to resemble a Doge dog. As a result, he became known as DOGSKI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_ea46fcc3d3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGSKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

