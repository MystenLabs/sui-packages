module 0xbd8203b9a7ebe26e1b93224a68e698d926124b7d9d26a2e3c50026d2b89d0e45::kumo {
    struct KUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMO>(arg0, 6, b"KUMO", b"Kumo Cat", b"Kumo cat on water chain. Suinami is coming. Next big thing thooon!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kumo_0bef5559d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

