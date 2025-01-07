module 0x908d3e736bdc438f7da0f4c16f42d4e4de651df80c00424769283fcf55e1c7c3::bitgums {
    struct BITGUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITGUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITGUMS>(arg0, 6, b"BITGUMS", b"Sui Bitgums", b"Bitgums is cleaning up his act and ready to take the meme universe by storm. Get ready for a fresh perspective and a whole lot of disruption!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048539_938c9d8f18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITGUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITGUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

