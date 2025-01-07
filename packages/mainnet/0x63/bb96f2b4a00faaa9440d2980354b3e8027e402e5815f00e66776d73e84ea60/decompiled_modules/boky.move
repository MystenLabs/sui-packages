module 0x63bb96f2b4a00faaa9440d2980354b3e8027e402e5815f00e66776d73e84ea60::boky {
    struct BOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOKY>(arg0, 6, b"BOKY", b"Sui Boky", b"$BOKY. The most memeable memecoin in existence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_49_b07767076d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

