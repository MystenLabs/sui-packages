module 0xeb0b8910274cdb5fa759d4e113c1b03c638157e43f8719c5ae23367eed43b0ff::azuki {
    struct AZUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZUKI>(arg0, 6, b"AZUKI", b"Sui Azuki", b"Airdropping 8888 Azukis to the SUI community & holders of $AZUKI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_720e127bb0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

