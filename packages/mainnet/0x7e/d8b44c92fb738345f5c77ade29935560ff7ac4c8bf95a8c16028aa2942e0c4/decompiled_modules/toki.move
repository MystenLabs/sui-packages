module 0x7ed8b44c92fb738345f5c77ade29935560ff7ac4c8bf95a8c16028aa2942e0c4::toki {
    struct TOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKI>(arg0, 6, b"TOKI", b"TOKI THE HIPPO DOG", x"46616d6f757320486970706f202b20446f672067656e65746963206d75746174696f6e200a24544f4b490a546f6b69206973206e6f206f7264696e61727920707570707968657320612064656c6967687466756c206d6978206f6620646f6720616e6420686970706f2c207468616e6b7320746f206120756e697175652067656e65746963206d75746174696f6e207468617420686173206769667465642068696d20776974682061206f6e652d6f662d612d6b696e64206c6f6f6b2e0a0a68747470733a2f2f7777772e74696b746f6b2e636f6d2f40746f6b69746865686970706f646f673f5f743d3871433843376b37576544265f723d310a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3620_d4b692bfe2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

