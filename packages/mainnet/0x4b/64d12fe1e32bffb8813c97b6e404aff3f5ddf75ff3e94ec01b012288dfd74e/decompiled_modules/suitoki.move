module 0x4b64d12fe1e32bffb8813c97b6e404aff3f5ddf75ff3e94ec01b012288dfd74e::suitoki {
    struct SUITOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOKI>(arg0, 6, b"SUITOKI", b"TOKI HIPPO DOG", x"46616d6f757320486970706f202b20446f672067656e65746963206d75746174696f6e200a24544f4b490a546f6b69206973206e6f206f7264696e61727920707570707968657320612064656c6967687466756c206d6978206f6620646f6720616e6420686970706f2c207468616e6b7320746f206120756e697175652067656e65746963206d75746174696f6e207468617420686173206769667465642068696d20776974682061206f6e652d6f662d612d6b696e64206c6f6f6b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3507_2a4b8701ae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

