module 0xd59c247863c7d405f96b80e82aff09e5f36e15c4f5998d44a047e875f38eddc1::suifur {
    struct SUIFUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUR>(arg0, 6, b"SUIFUR", b"Suifur", b"In the wild world of crypto, where innovation meets meme culture, SUIFUR ignites a new spark.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/periodic_table_element_sulfur_vector_24960013asdasdas_45efcfe733.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

