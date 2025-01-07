module 0x41ea8bc62c0fcbd1cf6637624e0cbbbd31c733397becfb830b54df21400069b5::suitizen {
    struct SUITIZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITIZEN>(arg0, 6, b"Suitizen", b"Double up citizen", b"For the suitizens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0526_f5a8209fde.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITIZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITIZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

