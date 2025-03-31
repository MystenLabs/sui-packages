module 0x9c18dfa4ee1189d8f2f9555e8ac1bf6d769d15e7d83a3478bdf6a812347d34ea::mn {
    struct MN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MN>(arg0, 9, b"MN", b"min", b"yelow min", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/12e6feea73c6f08b5982c87717161ab8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

