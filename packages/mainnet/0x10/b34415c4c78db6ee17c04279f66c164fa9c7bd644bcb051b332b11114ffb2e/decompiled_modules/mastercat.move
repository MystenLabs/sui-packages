module 0x10b34415c4c78db6ee17c04279f66c164fa9c7bd644bcb051b332b11114ffb2e::mastercat {
    struct MASTERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASTERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASTERCAT>(arg0, 6, b"Mastercat", b"MASTERCAT Card", b"Mastercat Card - movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdasdasdasd_3a93699759.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASTERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASTERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

