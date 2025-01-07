module 0xa3960f09bfa3f32155f9163ee43a5b2177077b33d3012168e01e51a78cc4cf62::seeyou {
    struct SEEYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEYOU>(arg0, 9, b"SEEYOU", b"See you", b"See you again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8dc04fd3-4b70-4a7e-94f8-2f33df5025ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

