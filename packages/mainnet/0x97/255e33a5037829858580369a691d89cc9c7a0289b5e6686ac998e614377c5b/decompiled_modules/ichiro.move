module 0x97255e33a5037829858580369a691d89cc9c7a0289b5e6686ac998e614377c5b::ichiro {
    struct ICHIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICHIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICHIRO>(arg0, 6, b"ICHIRO", b"Ichiro Inu", b"Ichiro: The meme coin with a heart of gold and a spirit that never surrenders! Join our pack as we embark on a crypto adventure world wide!  #IchiroArmy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J7_TDGJG_3_400x400_476eb008b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICHIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICHIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

