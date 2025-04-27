module 0x148aaf31bb51d6465d40a2e8958ca32bfe7161424fce4825b939620b2b1a84f::kone {
    struct KONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONE>(arg0, 9, b"KONE", b"Karrierone", b"Decentralized telecom solutions on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/58f0f4c81389eba939692cf871ebfdc7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

