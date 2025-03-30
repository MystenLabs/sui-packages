module 0xb6b76d10d6f15d8f5a8b7703978d0d993bc9361ccbcd58afb64bdb185a3d2628::eid {
    struct EID has drop {
        dummy_field: bool,
    }

    fun init(arg0: EID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EID>(arg0, 9, b"Eid", b"EidCoin", b"The name \"EidCoin\" is inspired by \"Eid al-Fitr,\" the celebration of Lebaran filled with meaning. A supply of 1 billion symbolizes the abundance of blessings and joy shared during Eid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e2753af3ea644f8cb1028f3a6f06b812blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EID>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EID>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

