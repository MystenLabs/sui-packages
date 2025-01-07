module 0xf9ba9a0f6b30717d319026ba41e460c196440ea9bd5c967017383909f8bf5f5c::meyo {
    struct MEYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEYO>(arg0, 6, b"MEYO", b"Meyo On Sui", b"while youre out and about searching for your next play, dont get $meyo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meyo_6ceeff6e84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

