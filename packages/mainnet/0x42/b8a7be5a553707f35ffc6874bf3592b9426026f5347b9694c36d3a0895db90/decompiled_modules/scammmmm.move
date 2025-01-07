module 0x42b8a7be5a553707f35ffc6874bf3592b9426026f5347b9694c36d3a0895db90::scammmmm {
    struct SCAMMMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAMMMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAMMMMM>(arg0, 9, b"SCAMMMMM", b"Scam lan nuxa", b"Mua di dcm chung may", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/aa2481c408f736cb83a4694f96cc3515blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAMMMMM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAMMMMM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

