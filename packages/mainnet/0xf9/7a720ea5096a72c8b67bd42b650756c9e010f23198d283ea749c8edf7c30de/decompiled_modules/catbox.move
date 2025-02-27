module 0xf97a720ea5096a72c8b67bd42b650756c9e010f23198d283ea749c8edf7c30de::catbox {
    struct CATBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOX>(arg0, 6, b"CATBOX", b"Cat In a Box", b"Curiosity and flexibility, like a Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/77a084bf-5e1e-4c07-91e9-250dfefe2dab.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATBOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

