module 0x15780a0f0cb69dc3fec00e9a485b92826529b14ca4efc4542e6d6ac2854c36bd::nutzpad {
    struct NUTZPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTZPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTZPAD>(arg0, 6, b"NUTZPAD", b"Sui Nutzpad", b" Get ready to hop on the #Nutzpad rocket #crypto #memecoin! The grasshopper is charged up and almost ready for takeoff to the moon!  Don't miss out on this wild ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061192_8f6ff48b7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTZPAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTZPAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

