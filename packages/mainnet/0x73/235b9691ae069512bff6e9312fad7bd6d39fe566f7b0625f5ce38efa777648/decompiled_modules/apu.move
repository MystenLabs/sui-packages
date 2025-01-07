module 0x73235b9691ae069512bff6e9312fad7bd6d39fe566f7b0625f5ce38efa777648::apu {
    struct APU has drop {
        dummy_field: bool,
    }

    fun init(arg0: APU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APU>(arg0, 6, b"APU", b"APU ON SUI", b"Apu Apustaja isn't just another memecoin; it's a symbol of resilience and the power of diversity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003596_8e7ea2f6cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APU>>(v1);
    }

    // decompiled from Move bytecode v6
}

