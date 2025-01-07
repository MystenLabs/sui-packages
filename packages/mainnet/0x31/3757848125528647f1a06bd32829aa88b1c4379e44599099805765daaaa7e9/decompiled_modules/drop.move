module 0x313757848125528647f1a06bd32829aa88b1c4379e44599099805765daaaa7e9::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROP>(arg0, 6, b"DROP", b"Master Raindrop", b"$DROP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_C_Vdmi_MT_400x400_870b670ebf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

