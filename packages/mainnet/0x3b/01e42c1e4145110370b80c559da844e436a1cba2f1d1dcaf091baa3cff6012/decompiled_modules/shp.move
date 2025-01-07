module 0x3b01e42c1e4145110370b80c559da844e436a1cba2f1d1dcaf091baa3cff6012::shp {
    struct SHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHP>(arg0, 6, b"SHP", b"SUIHopFish", b"They say fish don't jump, I'm an exception", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/8_8_E4lh_400x400_72eb1535c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

