module 0x9cd8a94f852a4106eaca0b0024363a8afee80386965f084d9f132f5d661ed652::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 9, b"PHARMA", b"Pharmasui", b"Side effects may include massive gains, euphoria & fomo. The battle against big pharma begins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Nczzed4.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPUMP>>(0x2::coin::mint<SUIPUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIPUMP>>(v2);
    }

    // decompiled from Move bytecode v7
}

