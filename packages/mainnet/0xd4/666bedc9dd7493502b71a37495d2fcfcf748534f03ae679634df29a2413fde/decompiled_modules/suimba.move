module 0xd4666bedc9dd7493502b71a37495d2fcfcf748534f03ae679634df29a2413fde::suimba {
    struct SUIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMBA>(arg0, 6, b"SUIMBA", b"Suimba", b"Meet Suimba, the most adorable mascot of the Sui Network. Suimba is light blue lion cub who embodies courage and adventure, destined for the throne of Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/URF_7_103188cfdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

