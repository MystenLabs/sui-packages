module 0xf8752f125d0f273c7fab0c7faff4f1202be214e40dd86a8bc7f4b7d8465641e9::jdawg {
    struct JDAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDAWG>(arg0, 6, b"JDAWG", b"Jdawg", b"fella on da coast enjoying lyfe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.pexels.com/photos/1560666/pexels-photo-1560666.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JDAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

