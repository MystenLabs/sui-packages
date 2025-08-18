module 0xe7ff5f841fca7b4886acd909884e7d9f42d3f46b935ca129df49fe33090ec5c4::Dev_Test {
    struct DEV_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV_TEST>(arg0, 9, b"DEVTEST", b"Dev Test", b"dev test isa test for the widget", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/50e3650f-bf01-4a6e-8820-390f835fd5de.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEV_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV_TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

