module 0xddc0d7b7f2545a7c7a6155f6cc292c212a0518b766b6be62abd9c6c06b7a4b52::saw {
    struct SAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAW>(arg0, 6, b"SAW", b"SAW_TOKEN", b"Will you survive the ride, or will SAW take its toll?  #SAWToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000080961_63252b22b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

