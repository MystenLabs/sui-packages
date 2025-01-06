module 0x5e4f8cd0de3222c989791b44a334eb68332f4a4971653a40d7e3928016788b51::rbf {
    struct RBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBF>(arg0, 6, b"RBF", b"Rooster Blue Fly", b"RBF Will be FLY in the sui network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021601_463747b183.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RBF>>(v1);
    }

    // decompiled from Move bytecode v6
}

