module 0xaed9f49f45a7bb4a860e62d9f80258cd2ddfcf6c185760cd3a5323f9ba244c79::itrump {
    struct ITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ITRUMP>(arg0, 6, b"ITRUMP", b"iTRUMP by SuiAI", b"Make Ai Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000007356_5e2c40d400.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ITRUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITRUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

