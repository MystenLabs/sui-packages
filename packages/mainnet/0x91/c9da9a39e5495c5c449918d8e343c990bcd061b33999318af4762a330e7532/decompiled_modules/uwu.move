module 0x91c9da9a39e5495c5c449918d8e343c990bcd061b33999318af4762a330e7532::uwu {
    struct UWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UWU>(arg0, 6, b"UwU", b"SuuuWuuui", b"ssenpawi desu, pleaswe dontu huwtu me ando suppowtu me desu, imu actually owovewdoooseee aaaa ><", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suuuwuuui_b58fbabefc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

