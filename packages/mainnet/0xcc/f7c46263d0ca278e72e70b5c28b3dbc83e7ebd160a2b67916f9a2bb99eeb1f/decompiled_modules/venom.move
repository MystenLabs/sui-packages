module 0xccf7c46263d0ca278e72e70b5c28b3dbc83e7ebd160a2b67916f9a2bb99eeb1f::venom {
    struct VENOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENOM>(arg0, 9, b"VENOM", b"VENOM Symbiont", b"Venom like a movie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.redwolf.in/image/cache/catalog/artwork-Images/mens/Digital/venom-x-carnage-t-shirt-india-artwork-500x667.jpg?m=1687857269")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VENOM>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENOM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VENOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

