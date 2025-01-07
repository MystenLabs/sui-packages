module 0x130c5de52a7dbfc81de1c3fdbda843cc47484940f8ab6fbc7705d23e8117cd2b::dolan {
    struct DOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLAN>(arg0, 6, b"DOLAN", b"Dolan Duck", x"476f6f627920747269656420746f20737465657220746568207368697020616e642062652063707461696e206275742068657a206469656420756e646572206d7973746572696f75732063697263756d7374616e6365732e2020446f6c616e20697a2064652063707461696e206e6f772e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_a9bcd3d024.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

