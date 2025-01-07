module 0x3ec80ca546bd4b5fcbbafa4c78f04ebd9b78b790c896b1c4e94a7cbba2f2d0f3::suishidog {
    struct SUISHIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIDOG>(arg0, 6, b"SUISHIDOG", b"Suishi Dog", b"Suishi with a twist of paw-some perfection, combining the playful energy of dogs and the art of sushiSUISHIDOG $WOOF style! https://x.com/SuishiDogSUI https://suishidog.fun/ https://t.me/suishidogportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241221_181158_110_73f3112b6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

