module 0x493ed22aa5f3889aa7273669b6e4af71b8cd64c561d80047f228cfd6abe6ddd::myw {
    struct MYW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYW>(arg0, 6, b"Myw", b"wow", b"this is a my wow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_c34ff39869.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYW>>(v1);
    }

    // decompiled from Move bytecode v6
}

