module 0x354eab2a6cc837a3b8226883cc8d05d4fb9ac167fa09cd84d6e7ba048351c141::suizzly {
    struct SUIZZLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZZLY>(arg0, 6, b"SUIZZLY", b"SUIZZLY BEAR", b"A grizzly ($SUIZZLY) -polar-bear-hybrid is a rare ursid hybrid that has occurred both in captivity and in the wild.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3824_faa4d6dacd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZZLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZZLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

