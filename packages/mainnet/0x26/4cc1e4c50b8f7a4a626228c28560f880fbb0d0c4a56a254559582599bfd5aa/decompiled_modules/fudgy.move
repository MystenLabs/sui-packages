module 0x264cc1e4c50b8f7a4a626228c28560f880fbb0d0c4a56a254559582599bfd5aa::fudgy {
    struct FUDGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDGY>(arg0, 6, b"FUDGY", b"Fudgy Penguinis", b"Fudgy Penguinis & Friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ko6tejzfueu6hdmt3gk7tfpmsriguun24hrrym46hhyw4h35mmya.arweave.net/U70yJyWhKeONk9mV-ZXslFBqUbrh4xwznjnxbh99YzA")), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FUDGY>>(0x2::coin::mint<FUDGY>(&mut v2, 88888888888000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FUDGY>>(v2);
    }

    // decompiled from Move bytecode v6
}

