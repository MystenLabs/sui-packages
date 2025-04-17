module 0xdea81c03c7dc0bcb61874fc1a1174143704ed361665fac51b210b32a98efbf9f::mqe {
    struct MQE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MQE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MQE>(arg0, 9, b"MQE", b"MONQUE", b"1000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/17161895200568f70b7b09dfb65aa2a8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MQE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MQE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

