module 0xc6b695b65859030c18eced592c7548af682f8ba7db761539acb87a5cd2bad46f::egx {
    struct EGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGX>(arg0, 9, b"EGX", b"Egurex", b"Web 3 enthusiast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/87178d156a8927c8140db302df71745cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

