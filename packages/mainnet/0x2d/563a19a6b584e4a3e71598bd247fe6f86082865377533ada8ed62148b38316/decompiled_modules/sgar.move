module 0x2d563a19a6b584e4a3e71598bd247fe6f86082865377533ada8ed62148b38316::sgar {
    struct SGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGAR>(arg0, 6, b"SGAR", b"SUIGAR", b"$SUIGAR is an experiment to create a decentralized verification platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240929_120951_de66596134.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

