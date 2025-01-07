module 0x39a0710d7bbb890c69b686cf34ff4918be35e6acedaef23f6820c54d58101daa::arf {
    struct ARF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARF>(arg0, 6, b"ARF", b"SuiArf", b"Arf On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ARF_f19cf3afe5.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARF>>(v1);
    }

    // decompiled from Move bytecode v6
}

