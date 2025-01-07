module 0x39f33c4c5392db857524b27e38eb37c39208a2661306a56a21f7958a9764091d::srx {
    struct SRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRX>(arg0, 6, b"SRX", b"suiREX", b"only Hop Agregator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3z_BW_58ly_400x400_78e85ba293.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

