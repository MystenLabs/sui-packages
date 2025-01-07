module 0x3dd6fbcf470d81ca586a3a43e343c4a472b3d3f25540284caef43a945b692683::cow {
    struct COW has drop {
        dummy_field: bool,
    }

    fun init(arg0: COW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COW>(arg0, 6, b"COW", b"Surfing Cow", b"Surfing cow on a ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SURF_e4cec7de61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COW>>(v1);
    }

    // decompiled from Move bytecode v6
}

