module 0xf5c0c6763d85ed966e06b9cae432c56f4ea5c5a9ebb58658df5661daf45b0c59::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROP>(arg0, 6, b"DROP", b"DROPPY", b"Droppy On Sui is an adventurous little droplet . Here to spread awareness of the awesomeness of SUI ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5c3647ea_857a_4c92_9fdc_a6862fe5a985_a46c6abe79.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

