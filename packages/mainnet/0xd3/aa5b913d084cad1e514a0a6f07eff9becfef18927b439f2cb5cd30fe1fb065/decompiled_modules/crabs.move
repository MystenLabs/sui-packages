module 0xd3aa5b913d084cad1e514a0a6f07eff9becfef18927b439f2cb5cd30fe1fb065::crabs {
    struct CRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABS>(arg0, 6, b"CRABS", b"Coconut Crabs", b"The Coconut Crabs are coming... and they want Amelia Earhart's flesh!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_8f681d3105.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

