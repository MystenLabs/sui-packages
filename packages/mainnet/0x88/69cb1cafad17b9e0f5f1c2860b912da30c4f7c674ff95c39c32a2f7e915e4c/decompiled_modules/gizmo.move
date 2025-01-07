module 0x8869cb1cafad17b9e0f5f1c2860b912da30c4f7c674ff95c39c32a2f7e915e4c::gizmo {
    struct GIZMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIZMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIZMO>(arg0, 6, b"GIZMO", b"Gizmotherabbit SUI", b"GizmoTheRabbit sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hero_7a05696cab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIZMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIZMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

