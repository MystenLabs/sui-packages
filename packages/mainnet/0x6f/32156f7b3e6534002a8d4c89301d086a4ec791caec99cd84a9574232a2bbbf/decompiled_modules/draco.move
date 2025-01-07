module 0x6f32156f7b3e6534002a8d4c89301d086a4ec791caec99cd84a9574232a2bbbf::draco {
    struct DRACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRACO>(arg0, 6, b"Draco", b"DraconiSUI", b"Draconis is an enormous amphibian, far larger than any known species", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241128_034629_880_18af9e09f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

