module 0xf84b084d86fdbd9045035facdb23461e1ebce0999da3cc53a172e82246fee7f8::grd {
    struct GRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRD>(arg0, 9, b"GRD", b"Garuda", b"Garuda Coin is not just a cryptocurrency; it is a movement toward financial empowerment and digital transformation, aiming to bridge the gap between traditional finance and the emerging digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f804b14-caa9-4cf2-80e1-179c79d55812.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

