module 0xa4faa0249c017509bb5c889893dc2211f457da97e5a805a65ca086039d114d5c::vogya {
    struct VOGYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOGYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOGYA>(arg0, 6, b"VOGYA", b"Sui Vogya", b"VOGYA - DREAM AND ADVENTURE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015108_5d0d15233a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOGYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOGYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

