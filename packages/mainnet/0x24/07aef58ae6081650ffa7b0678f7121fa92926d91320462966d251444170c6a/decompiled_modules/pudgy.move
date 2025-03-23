module 0x2407aef58ae6081650ffa7b0678f7121fa92926d91320462966d251444170c6a::pudgy {
    struct PUDGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGY>(arg0, 6, b"PUDGY", b"Pudgy Penguins", b"Pudgy Penguins & Friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ko6tejzfueu6hdmt3gk7tfpmsriguun24hrrym46hhyw4h35mmya.arweave.net/U70yJyWhKeONk9mV-ZXslFBqUbrh4xwznjnxbh99YzA")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PUDGY>>(0x2::coin::mint<PUDGY>(&mut v2, 88888888888000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDGY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUDGY>>(v2);
    }

    // decompiled from Move bytecode v6
}

