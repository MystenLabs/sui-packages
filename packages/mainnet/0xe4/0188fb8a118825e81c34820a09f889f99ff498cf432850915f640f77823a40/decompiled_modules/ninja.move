module 0xe40188fb8a118825e81c34820a09f889f99ff498cf432850915f640f77823a40::ninja {
    struct NINJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINJA>(arg0, 6, b"NINJA", b"Shinobi", b"IN THE SHADOWY REALMS OF THE DIGITAL CURRENCY WORLD, WHERE TRENDS CHANGE FASTER THAN THE BLINK OF AN EYE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZEKE_1710f9c1ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

