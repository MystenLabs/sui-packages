module 0x24fa5b4d76b4692a11a2062611fc4513fce1a90e63ef8f010cb65dd5f7ceee1f::slc {
    struct SLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLC>(arg0, 6, b"SLC", b"Sui Long Cat", b"alrighty, listen up! Ever heard of Long Cat? Picture this: a kitty with a neck so long, it could wrap around the planet twice before breakfast. This ain't your average feline, no sir! Long Cat struts around sui like it owns the place, giving sass to anyone who dares cross its path.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLC>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

