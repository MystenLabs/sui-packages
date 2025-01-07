module 0xa702e4f48ed5f8a3381f6ba2b92e8be4c4f31da7bc06137d94ce6045e5003884::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"Siamese Cat", b"Its believed that Siamese cats first appeared in Siam's ancient Asian land (nowadays Thailand), and thats how the breed got its name.  In Siam, the stunning cats were exclusive to the royal family and the higher class. It was a great honor to receive a Siamese cat and the theft of one was punishable by death. Its also said that the Siamese cats guarded the sacred Buddhist temples. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0073_732a5f18aa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

