module 0x5f9b9d634e1c6957a7afdc578f635abbfdf52655ca5390c02ac98cf330d63057::dgu {
    struct DGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGU>(arg0, 9, b"DGU", b"DuckGuy", b"duck duck fam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/315b33921035ebdab75e90a8a5de40f5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

