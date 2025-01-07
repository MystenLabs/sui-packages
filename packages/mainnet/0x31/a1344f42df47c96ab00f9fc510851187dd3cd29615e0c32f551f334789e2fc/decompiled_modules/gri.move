module 0x31a1344f42df47c96ab00f9fc510851187dd3cd29615e0c32f551f334789e2fc::gri {
    struct GRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRI>(arg0, 9, b"GRI", b"GRINCH", b"Introducing Grinch, the Christmas cryptocurrency on the Sui network. Designed to celebrate the holiday spirit, Grinch offers fast and secure transactions, perfect for gifting and sharing during the festive season. Join the holiday revolution with Grinch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/32774c40328ec35000dcb83b427cb15bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

