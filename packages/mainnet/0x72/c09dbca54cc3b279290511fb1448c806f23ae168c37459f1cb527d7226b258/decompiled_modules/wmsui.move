module 0x72c09dbca54cc3b279290511fb1448c806f23ae168c37459f1cb527d7226b258::wmsui {
    struct WMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMSUI>(arg0, 6, b"WMSUI", b"Waterman", b"Waterman, the SUIperhero. Be water MF.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n5_Ct_l_Ep_400x400_ceee7b9bfd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

