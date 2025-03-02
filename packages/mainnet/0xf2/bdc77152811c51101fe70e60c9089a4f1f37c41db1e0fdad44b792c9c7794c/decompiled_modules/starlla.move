module 0xf2bdc77152811c51101fe70e60c9089a4f1f37c41db1e0fdad44b792c9c7794c::starlla {
    struct STARLLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARLLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARLLA>(arg0, 6, b"STARLLA", b"Star&Stella", b"Star and Stella are identical twins. They are happy, healthy, cute, smart, nice, very talented and they are the sweetest twins in the universe. Daddy loves them very much. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/starlla_icon_5c287da86d.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARLLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARLLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

