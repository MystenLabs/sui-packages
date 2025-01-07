module 0x13ebea4fe93fd31738d4233c539ba9e59f43e538def234dc2c2708393ee4cf5c::aly {
    struct ALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALY>(arg0, 9, b"ALY", b"ALY", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

