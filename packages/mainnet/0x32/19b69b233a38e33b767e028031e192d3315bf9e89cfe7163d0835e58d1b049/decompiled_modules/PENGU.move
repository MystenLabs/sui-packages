module 0x3219b69b233a38e33b767e028031e192d3315bf9e89cfe7163d0835e58d1b049::PENGU {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"PENGU", b"Pudgy Penguins", b"For the people. By the people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ko6tejzfueu6hdmt3gk7tfpmsriguun24hrrym46hhyw4h35mmya.arweave.net/U70yJyWhKeONk9mV-ZXslFBqUbrh4xwznjnxbh99YzA")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU>>(v1);
        0x2::coin::mint_and_transfer<PENGU>(&mut v2, 88888888888000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PENGU>>(v2);
    }

    // decompiled from Move bytecode v6
}

