module 0x92d836035935e374d4d06b57b44539dcad7e7809b4cdb7c2bd561feb385836f::rrarar {
    struct RRARAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRARAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRARAR>(arg0, 6, b"Rrarar", b"rzrzrz", b"arara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ADA_3_c541696232.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRARAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RRARAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

