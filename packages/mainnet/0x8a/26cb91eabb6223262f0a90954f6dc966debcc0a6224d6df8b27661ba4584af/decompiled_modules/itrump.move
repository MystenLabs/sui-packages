module 0x8a26cb91eabb6223262f0a90954f6dc966debcc0a6224d6df8b27661ba4584af::itrump {
    struct ITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ITRUMP>(arg0, 6, b"ITRUMP", b"iTRUMP by SuiAI", b"Make Ai Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000007356_6005af7348.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ITRUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITRUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

