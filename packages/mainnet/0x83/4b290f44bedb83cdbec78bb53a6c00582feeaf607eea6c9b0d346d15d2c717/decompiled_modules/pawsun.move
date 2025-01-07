module 0x834b290f44bedb83cdbec78bb53a6c00582feeaf607eea6c9b0d346d15d2c717::pawsun {
    struct PAWSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWSUN>(arg0, 6, b"PAWSUN", b"Sui Pawsun", b"The purr-fect blend of charm and crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012388_9b4b397f9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWSUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWSUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

