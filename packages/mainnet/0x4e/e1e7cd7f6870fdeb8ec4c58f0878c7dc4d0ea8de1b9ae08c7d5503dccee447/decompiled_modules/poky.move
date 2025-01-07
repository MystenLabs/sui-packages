module 0x4ee1e7cd7f6870fdeb8ec4c58f0878c7dc4d0ea8de1b9ae08c7d5503dccee447::poky {
    struct POKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKY>(arg0, 6, b"POKY", b"Sui Poky", b"$POKY swims through the sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_70_34fa8b891e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

