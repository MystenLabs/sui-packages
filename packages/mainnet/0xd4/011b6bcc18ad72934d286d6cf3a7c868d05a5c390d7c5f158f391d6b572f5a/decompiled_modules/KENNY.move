module 0xd4011b6bcc18ad72934d286d6cf3a7c868d05a5c390d7c5f158f391d6b572f5a::KENNY {
    struct KENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENNY>(arg0, 9, b"KENNY", b"Clark Kenny", b"Clark Kenny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1747649910013571073/SWQbbuiS_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KENNY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KENNY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

