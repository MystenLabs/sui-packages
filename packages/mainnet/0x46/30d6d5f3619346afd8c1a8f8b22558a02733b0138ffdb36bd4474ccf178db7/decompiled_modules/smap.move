module 0x4630d6d5f3619346afd8c1a8f8b22558a02733b0138ffdb36bd4474ccf178db7::smap {
    struct SMAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAP>(arg0, 6, b"SMAP", b"SUI Meme After Party", b"Who wanna join our year end party ? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_Air_39d_400x400_a0769ccb70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

