module 0x5364b16ebc11ddb59ba514c751b9839c0e4f9ae3c746d054dc8242874369d5c6::kkmi {
    struct KKMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKMI>(arg0, 9, b"KKMI", b"Kokomi", b"The young Divine Priestess of Watatsumi Island and a descendant of the Sangonomiya Clan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86d04c2f-da32-4ebf-bdc0-a3aa1e0949da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

