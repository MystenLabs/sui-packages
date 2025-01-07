module 0x814818bf4ab9942a650fa716a6b209364adee50cf34468223a4aae020a75d8ff::mpepe {
    struct MPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPEPE>(arg0, 6, b"MPEPE", b"MINI PEPE", b"Pepe reincarnated? Say No More. Pepe is at 3B, Mini Pepe is here to take over from Pepe! Mini Pepe is here to take the crypto space by storm, be a part of the revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_20_24_36_d6c5ae899d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

