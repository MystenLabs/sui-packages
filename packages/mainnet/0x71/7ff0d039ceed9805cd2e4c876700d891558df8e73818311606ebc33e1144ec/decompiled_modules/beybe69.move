module 0x717ff0d039ceed9805cd2e4c876700d891558df8e73818311606ebc33e1144ec::beybe69 {
    struct BEYBE69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEYBE69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEYBE69>(arg0, 9, b"Beybe69", b"Beybe", b"Ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/532c6ab8a2035fef48a3853a41ca137cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEYBE69>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEYBE69>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

