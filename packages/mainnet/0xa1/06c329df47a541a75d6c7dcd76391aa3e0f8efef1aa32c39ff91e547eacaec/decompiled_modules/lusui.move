module 0xa106c329df47a541a75d6c7dcd76391aa3e0f8efef1aa32c39ff91e547eacaec::lusui {
    struct LUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUSUI>(arg0, 6, b"LUSUI", b"LU", b"Cute demon chilling in a very cold place.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zqlc1_HT_7_400x400_193c3be409.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

