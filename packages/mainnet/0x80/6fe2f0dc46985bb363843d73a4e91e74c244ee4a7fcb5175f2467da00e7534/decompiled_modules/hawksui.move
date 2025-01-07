module 0x806fe2f0dc46985bb363843d73a4e91e74c244ee4a7fcb5175f2467da00e7534::hawksui {
    struct HAWKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWKSUI>(arg0, 6, b"HAWKSUI", b"Hawk Sui", b"You gotta give them that Sui and spit on that thang!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030376_bcf77c9dbb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

