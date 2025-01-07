module 0x787272371a235286002c3ca488fbeab7ca6c25469cd5134c922542610abbb754::plab {
    struct PLAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAB>(arg0, 6, b"PLAB", b"PLAB SUI", b"PEPE LANDWOLF ANDY BRETT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Salinan_dari_Desain_Tanpa_Judul_3_9afde19336.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

