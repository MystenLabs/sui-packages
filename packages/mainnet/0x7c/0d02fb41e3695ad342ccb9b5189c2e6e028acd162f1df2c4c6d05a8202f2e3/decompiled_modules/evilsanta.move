module 0x7c0d02fb41e3695ad342ccb9b5189c2e6e028acd162f1df2c4c6d05a8202f2e3::evilsanta {
    struct EVILSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVILSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVILSANTA>(arg0, 6, b"EVILSANTA", b"Krampus (EVIL SANTA)", x"4b72616d70757320284556494c2053414e5441290a0a596f7572204e6967687474696d652043727970746d617320436f6d70616e696f6e2c204e617567687479206f72204e69636520244b72616d7075732077696c6c205261697365207468652050726963652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_28_22_39_19_969ffaefa4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVILSANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVILSANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

