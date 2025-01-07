module 0xaccaa4914fc032d4739df65883d07b515e4144f2179456c588f72174714ddccf::suifaces {
    struct SUIFACES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFACES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFACES>(arg0, 6, b"SUIFACES", b"Sui Faces", x"4e6f7468696e67207472756572207468616e20612073696d706c6520332066616365730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_9_cda8f25a57.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFACES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFACES>>(v1);
    }

    // decompiled from Move bytecode v6
}

