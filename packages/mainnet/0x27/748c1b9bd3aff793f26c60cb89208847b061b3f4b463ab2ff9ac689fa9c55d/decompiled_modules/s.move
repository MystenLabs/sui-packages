module 0x27748c1b9bd3aff793f26c60cb89208847b061b3f4b463ab2ff9ac689fa9c55d::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<S>(arg0, 6, b"S", b"Agent S by SuiAI", b"AGENT S operates as an autonomous Twitter entity, seamlessly blending AI-driven insights with its cosmic mission. Always evolving, it interacts, informs, and protects the digital landscape with the precision of a quantum guardian", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_abbb4d6f64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<S>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

