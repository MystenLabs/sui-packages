module 0x187b46abc320e00e6f43d81c9aacc97e81dc83720be4866b55d5e9df0048b131::dank {
    struct DANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANK>(arg0, 6, b"DANK", b"Dank Sui", b"Dank, the enigmatic and audacious character behind our meme token. With his wild escapades and unpredictable nature, Dank embodies the thrill and excitement that defines our community. From daring adventures to unexpected twists, Dank is the master of mischief, always pushing the boundaries and keeping us on our toes. Join us as we embark on an exhilarating journey with Dank, taking the crypto world by storm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_85af496c96.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

