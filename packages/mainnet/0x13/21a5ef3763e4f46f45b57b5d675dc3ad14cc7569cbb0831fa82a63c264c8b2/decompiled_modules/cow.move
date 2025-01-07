module 0x1321a5ef3763e4f46f45b57b5d675dc3ad14cc7569cbb0831fa82a63c264c8b2::cow {
    struct COW has drop {
        dummy_field: bool,
    }

    fun init(arg0: COW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COW>(arg0, 6, b"COW", b"COWSUI", x"24434f570a53706865726963616c20636f772065636f6e6f6d69637320706f776572656420627920566974616c696b204275746572696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R97_Wi8_Go_400x400_472c33afb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COW>>(v1);
    }

    // decompiled from Move bytecode v6
}

