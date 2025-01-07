module 0x42b4b497dbd95e9ed0ee20ef98beb09fc994b7fe4d7067e05a8f600a99581dad::chimy {
    struct CHIMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIMY>(arg0, 6, b"CHIMY", b"Sui Chimy", b"$CHIMY Harnesses the Power of Jumping, Rises to the Top of the Sea of Memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001321_d3df600fa9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

