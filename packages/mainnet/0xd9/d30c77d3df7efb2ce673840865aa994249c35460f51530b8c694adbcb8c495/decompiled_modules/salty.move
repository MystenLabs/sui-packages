module 0xd9d30c77d3df7efb2ce673840865aa994249c35460f51530b8c694adbcb8c495::salty {
    struct SALTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALTY>(arg0, 6, b"SALTY", b"Salty On Sui", b"One $Salty Boy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/salty_fea359b9de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

