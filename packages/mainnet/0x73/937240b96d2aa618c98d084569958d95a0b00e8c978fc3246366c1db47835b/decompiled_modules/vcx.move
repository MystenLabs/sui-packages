module 0x73937240b96d2aa618c98d084569958d95a0b00e8c978fc3246366c1db47835b::vcx {
    struct VCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCX>(arg0, 9, b"vcx", b"dsaf", b"fasdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiscan.xyz/static/media/SuiFullLogo.81fc1b1392650f2473ab5733034fda73.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

