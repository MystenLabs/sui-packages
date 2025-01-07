module 0xe6429eacbe75275d246fd9a3457a6ccb94293b9ad4b7920965d83a87a65199cf::bscf {
    struct BSCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSCF>(arg0, 6, b"BSCF", b"Blessed Smoking Chicken Fish", x"416674657220737563682073756363657373206f6e20536f6c616e612e20200a57652068617665206172726976656420746f2074686520535549204e6574776f726b2e0a53707265616420646973656173652e20426520626c65737365642e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ufz_Fz_G2_R_400x400_f4cc154a17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

