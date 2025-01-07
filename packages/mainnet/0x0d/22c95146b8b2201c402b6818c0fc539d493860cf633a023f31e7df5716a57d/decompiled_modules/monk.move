module 0xd22c95146b8b2201c402b6818c0fc539d493860cf633a023f31e7df5716a57d::monk {
    struct MONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONK>(arg0, 6, b"MONK", b"Monk Fish On Sui", b"$monk the spoky fish on sui ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_021242_48d0e80b0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

