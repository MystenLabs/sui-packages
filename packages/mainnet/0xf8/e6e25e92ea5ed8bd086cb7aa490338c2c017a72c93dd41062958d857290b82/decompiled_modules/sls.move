module 0xf8e6e25e92ea5ed8bd086cb7aa490338c2c017a72c93dd41062958d857290b82::sls {
    struct SLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLS>(arg0, 6, b"SLS", b"SunCloudSui", b"The Sun is shining, the Clouds are floating, let's adventure together Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_8e747c681c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

