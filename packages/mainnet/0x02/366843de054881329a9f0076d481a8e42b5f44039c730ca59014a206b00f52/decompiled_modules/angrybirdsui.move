module 0x2366843de054881329a9f0076d481a8e42b5f44039c730ca59014a206b00f52::angrybirdsui {
    struct ANGRYBIRDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRYBIRDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRYBIRDSUI>(arg0, 6, b"Angrybirdsui", b"Angry bird sui", b"Join Angry Birds  community as we will make a big noise in sui blockchain, we will make it happen together ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241019_193834_Gallery_eb333781a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRYBIRDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGRYBIRDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

