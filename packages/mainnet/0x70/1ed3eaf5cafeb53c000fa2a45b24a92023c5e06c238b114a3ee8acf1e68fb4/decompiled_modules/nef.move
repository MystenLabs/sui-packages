module 0x701ed3eaf5cafeb53c000fa2a45b24a92023c5e06c238b114a3ee8acf1e68fb4::nef {
    struct NEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEF>(arg0, 9, b"NEF", b"Nefari", b"King Pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1820574436711383040/CCbfrOhJ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEF>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

