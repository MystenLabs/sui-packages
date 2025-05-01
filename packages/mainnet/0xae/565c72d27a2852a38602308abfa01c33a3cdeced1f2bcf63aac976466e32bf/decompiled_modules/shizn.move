module 0xae565c72d27a2852a38602308abfa01c33a3cdeced1f2bcf63aac976466e32bf::shizn {
    struct SHIZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIZN>(arg0, 6, b"Shizn", b"SUISHIZN", b"$SHIZN a combination of Rice and Fresh Fish. Should be in your bag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hebzu_Iz_U_400x400_144ce437de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIZN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIZN>>(v1);
    }

    // decompiled from Move bytecode v6
}

