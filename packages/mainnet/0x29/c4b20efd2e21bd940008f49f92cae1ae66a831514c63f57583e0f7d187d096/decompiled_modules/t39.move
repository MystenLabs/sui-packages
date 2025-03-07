module 0x29c4b20efd2e21bd940008f49f92cae1ae66a831514c63f57583e0f7d187d096::t39 {
    struct T39 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T39, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T39>(arg0, 9, b"T39", b"TOKEN39", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T39>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T39>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T39>>(v2);
    }

    // decompiled from Move bytecode v6
}

