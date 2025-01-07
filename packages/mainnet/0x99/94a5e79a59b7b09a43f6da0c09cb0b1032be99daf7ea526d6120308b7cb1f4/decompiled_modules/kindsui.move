module 0x9994a5e79a59b7b09a43f6da0c09cb0b1032be99daf7ea526d6120308b7cb1f4::kindsui {
    struct KINDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINDSUI>(arg0, 6, b"KINDSUI", b"KinderSUI", b"The Kinder Sui to the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000065890_36beb0bb40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

