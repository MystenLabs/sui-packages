module 0x7a42250c0cd26981c35f012616353c89e553682d73dc858fe48df90405de159e::dotr {
    struct DOTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTR>(arg0, 9, b"DoTr", b"Doland Tremp - TREMP", b"super hit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fca04ade3c7f98850bba90c9ce6bffdablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOTR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

