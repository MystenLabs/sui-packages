module 0x4385a996d170ca26be4f9a2ddcfcfc63a6d340f44d76873e4b8677ff44957cd7::vts {
    struct VTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTS>(arg0, 6, b"VTS", b"VectorSui", b"Mosquito Vector is looking for smart investors to conquer Sui Network together. Are you one of them?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_9b4bda6074.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

