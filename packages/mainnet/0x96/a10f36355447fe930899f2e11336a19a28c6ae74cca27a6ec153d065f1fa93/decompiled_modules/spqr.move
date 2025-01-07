module 0x96a10f36355447fe930899f2e11336a19a28c6ae74cca27a6ec153d065f1fa93::spqr {
    struct SPQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPQR>(arg0, 6, b"SPQR", b"Imperium Romanum Sacrum", b"Deployed to preserve the myth of a \"Roman Empire world order conspiracy\" suggesting the influence and control mechanisms of the Roman Empire have persisted and been adapted through the ages to ensure the fundamentals of a Digital Nation created by The New World Order $STATE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_858d00b63a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPQR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

