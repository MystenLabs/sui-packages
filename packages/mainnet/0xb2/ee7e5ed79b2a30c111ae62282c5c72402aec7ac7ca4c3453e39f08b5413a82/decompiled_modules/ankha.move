module 0xb2ee7e5ed79b2a30c111ae62282c5c72402aec7ac7ca4c3453e39f08b5413a82::ankha {
    struct ANKHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANKHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANKHA>(arg0, 6, b"ANKHA", b"Ankha On Sui", b"The new sassy Quen cat on sui , she started out as a computer game character theb became TIKTOK dance sensation followed by porn start!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250501_235355_387_195843a896.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANKHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANKHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

