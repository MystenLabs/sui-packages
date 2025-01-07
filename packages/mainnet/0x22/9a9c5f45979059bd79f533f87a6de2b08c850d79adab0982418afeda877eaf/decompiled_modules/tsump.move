module 0x229a9c5f45979059bd79f533f87a6de2b08c850d79adab0982418afeda877eaf::tsump {
    struct TSUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUMP>(arg0, 6, b"TSUMP", b"SUITRUMP", b"$TSUMP on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ndy_E_Ozdp3_Iz7uza_e78f4184ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

