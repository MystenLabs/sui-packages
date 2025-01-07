module 0x2a77b29960bc66e88a1ce959468f7c43f2105def7956cd39802983807c37e11a::flyingfish {
    struct FLYINGFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLYINGFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYINGFISH>(arg0, 6, b"FlyingFish", b"Flying Fish", b"Flying Fish is now flying over and diving into the Sui Ecosystem.  We are here forever and ever.  Join our Telegram!  https://t.me/FlyingFish_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c19bea581a9a423eabe6ee082a18630d_85fb880527.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYINGFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLYINGFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

