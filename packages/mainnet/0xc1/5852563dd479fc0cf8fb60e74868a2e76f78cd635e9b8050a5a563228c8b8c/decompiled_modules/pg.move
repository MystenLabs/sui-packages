module 0xc15852563dd479fc0cf8fb60e74868a2e76f78cd635e9b8050a5a563228c8b8c::pg {
    struct PG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PG>(arg0, 9, b"PG", b"piggi", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d9758b8b79f4f98e7e5f8eaee7987951blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

